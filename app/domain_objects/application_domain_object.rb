# frozen_string_literal: true

class ApplicationDomainObject
  def initialize(model_instance)
    @data_model = model_instance
    singleton_class.delegate_missing_to :@data_model
  end

  def data_class_name
    self.class.data_class_name.to_s.classify
  end

  class << self
    attr_reader :data_class_name

    def uses_model(class_name)
      @data_class_name = class_name
    end
  end
end
