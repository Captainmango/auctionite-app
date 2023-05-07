# frozen_string_literal: true

module HasDomainObject
  extend ActiveSupport::Concern

  included do
    def domain_tap(sym_name)
      yield Object.const_get(sym_name).new(attributes)
      self
    end
  end
end
