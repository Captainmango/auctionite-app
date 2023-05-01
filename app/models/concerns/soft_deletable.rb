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
    update_column :deleted_at, Time.current if has_attribute? :deleted_at
    # rubocop:enable Rails/SkipsModelValidations
  end

  def destroy
    callbacks_result = transaction do
      run_callbacks(:destroy) do
        delete
      end
    end
    callbacks_result ? self : false
  end

  def self.included(klass)
    klass.extend Callbacks
  end

  module Callbacks
    def self.extended(klass)
      klass.define_callbacks :restore
      klass.define_singleton_method('before_restore') do |*args, &block|
        set_callback(:restore, :before, *args, &block)
      end

      klass.define_singleton_method('around_restore') do |*args, &block|
        set_callback(:restore, :around, *args, &block)
      end

      klass.define_singleton_method('after_restore') do |*args, &block|
        set_callback(:restore, :after, *args, &block)
      end
    end
  end

  # Somewhat gnarly with recursion on. USE WITH CAUTION
  #
  # When recursive: true -> Goes through all the has_* associations that have a dependent destroy
  # See restore_associated_records for deets
  #
  # Otherwise, just sets the deleted_at column to nil for the row
  def restore!(opts = {})
    self.class.transaction do
      run_callbacks(:restore) do
        # rubocop:disable Rails/SkipsModelValidations
        update_column :deleted_at, nil
        # rubocop:enable Rails/SkipsModelValidations
        restore_associated_records if opts[:recursive]
      end
    end
    self
  end

  alias restore restore!

  # process:
  # get all associations that have a dependent destroy
  # Get association data from said associations
  # As long as the association and deleted_at exist on the association (it has the trait and the field)
  # Go over each of the models calling restore. If only one, just call restore. Keep going recursively
  # until we find no more has_* associations. Once done, all will be restored.
  # Make sure we only have valid data in the association cache
  #
  # branches:
  # in the has_one case:
  # we enter the else branch of process_association and call the callback recursively.
  #
  # in the has_many case:
  # we enter the main body of the if and loop over the models in the collection
  #
  # in the has_and_belongs_to_many case:
  # we do the same as the has_many case, but continue down to process_sub_restore
  # This will find the associated model and get the soft deleted ones then *try* to restore it
  # this may not succeed as the model may not exist so returns nil in that case
  #
  # in the has_*_through case:
  # same as the has_many case. As a proper has_*_through has the normal has_* macro, it'll pick up
  # the models it needs to restore using process_association
  def restore_associated_records
    destroyed_associations = self.class.reflect_on_all_associations.select do |association|
      association.options[:dependent] == :destroy
    end

    handle_destroyed_associations(destroyed_associations)
    clear_association_cache if destroyed_associations.present?
  end

  private

  def handle_destroyed_associations(associations)
    associations.each do |association|
      association_data = send(association.name)
      process_association(association, association_data) if !association_data.nil? && association_data.deleted_at.nil?

      next unless association_data.nil? && association.macro.to_s == 'has_one'

      association_class_name = define_association_class_name(association)
      association_foreign_key = define_association_foreign_key(association)
      process_sub_restore(association_class_name, association_foreign_key)
    end
  end

  def define_association_class_name(association)
    association.options[:class_name].presence || association.name.to_s.camelize
  end

  def define_association_foreign_key(association)
    association.options[:foreign_key].presence || "#{self.class.name.to_s.underscore}_id"
  end

  def process_sub_restore(association_class_name, association_foreign_key)
    Object.const_get(association_class_name)
          .only_deleted.where(association_foreign_key, id)
          .first
          .try(
            :restore,
            recursive: true
          )
  end

  def process_restore(association, association_data)
    if association.collection?
      association_data.only_deleted.each { |record| record.restore(recursive: true) }
    else
      association_data.restore(recursive: true)
    end
  end
end
