# frozen_string_literal: true

module HasDomainObject
  extend ActiveSupport::Concern

  included do |base|
    base.extend ClassMethods

    def domain_tap(sym_name = nil)
      yield Object.const_get(sym_name || domain_class_name).new(attributes)
      self
    end

    def domain_class_name
      self.class.domain_class_name.to_s.classify
    end
  end

  module ClassMethods
    attr_reader :domain_class_name

    def uses_domain_object(class_name)
      @domain_class_name = class_name
    end
  end
end
