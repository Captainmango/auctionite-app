# frozen_string_literal: true

class ApplicationDomainObject
  include ActiveModel::Model

  class << self
    attr_reader :data_class_name, :data_model

    def uses_model(class_name)
      @data_class_name = class_name
      model
    end

    private

    def model
      @data_model ||= Object.const_get(data_class_name.to_s.classify)
      data_model
    end
  end

  def initialize(data = {})
    instance_variable_set("@#{data_class_name.downcase}_model", model)
    singleton_class.attr_reader("#{data_class_name.downcase}_model")
    attribute_names = self.class.data_model.attribute_names

    data.each do |key, value|
      if attribute_names.include?(key)
        instance_variable_set("@#{key}", value)
        singleton_class.attr_reader(key)
      else
        define_singleton_method(key) { value }
      end
    end

    super()
  end

  def data_class_name
    self.class.data_class_name.to_s.classify
  end

  def model
    self.class.data_model
  end

  def ==(other)
    if other.instance_of?(self.class)
      as_json == other.as_json
    else
      super
    end
  end
end
