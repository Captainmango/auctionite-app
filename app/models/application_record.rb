# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # @!parse
  #   extend HasDomainObject::ClassMethods
end
