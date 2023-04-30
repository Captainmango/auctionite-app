# frozen_string_literal: true

# Mixin for soft deleting models. Adds the scopes needed and a restore method so that we can bring
# models back if we want. Overrides the destroy and delete methods. The only way to hard delete a model
# with the mixin is via direct DB access.
module SoftDeletable
  extend ActiveSupport::Concern

  included do
    define_callbacks :soft_destroy, scope: %i[kind name]
    default_scope { where(deleted_at: nil) }
    scope :only_deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
    scope :with_deleted, -> { unscope(where: :deleted_at) }
  end

  def delete
    # rubocop:disable Rails/SkipsModelValidations
    update_column :deleted_at, Time.now if has_attribute? :deleted_at
  end

  def destroy
    callbacks_result = transaction do
      run_callbacks(:destroy) do
        delete
      end
    end
    callbacks_result ? self : false
  end

  def self.included(klazz)
    klazz.extend Callbacks
  end

  module Callbacks
    def self.extended(klazz)
      klazz.define_callbacks :restore
      klazz.define_singleton_method('before_restore') do |*args, &block|
        set_callback(:restore, :before, *args, &block)
      end
      klazz.define_singleton_method('around_restore') do |*args, &block|
        set_callback(:restore, :around, *args, &block)
      end
      klazz.define_singleton_method('after_restore') do |*args, &block|
        set_callback(:restore, :after, *args, &block)
      end
    end
  end

  def restore!(opts = {})
    self.class.transaction do
      run_callbacks(:restore) do
        update_column :deleted_at, nil
        restore_associated_records if opts[:recursive]
      end
    end
    self
  end

  alias restore restore!

  def restore_associated_records
    # get all associations that have a dependent destroy
    destroyed_associations = self.class.reflect_on_all_associations.select do |association|
      association.options[:dependent] == :destroy
    end

    # Go over each association
    destroyed_associations.each do |association|
      # Get its data
      association_data = send(association.name)
      # As long as the data exists and is not soft deleted
      unless association_data.nil?
        if association_data.deleted_at.nil?
          # If its a collection of items go over all of them and restore them
          # otherwise, just restore the singular one and recurse if necessary
          if association.collection?
            association_data.only_deleted.each { |record| record.restore(recursive: true) }
          else
            association_data.restore(recursive: true)
          end
        end
      end

      # If the association has been soft deleted and is a has_one, find all owned ones and restore them
      if association_data.nil? && association.macro.to_s == 'has_one'
        association_class_name = association.options[:class_name].present? ? association.options[:class_name] : association.name.to_s.camelize
        association_foreign_key = association.options[:foreign_key].present? ? association.options[:foreign_key] : "#{self.class.name.to_s.underscore}_id"
        Object.const_get(association_class_name).only_deleted.where(association_foreign_key, id).first.try(:restore, recursive: true)
      end
    end

    # Make sure we only have valid data in the association cache
    clear_association_cache if destroyed_associations.present?
  end
end
