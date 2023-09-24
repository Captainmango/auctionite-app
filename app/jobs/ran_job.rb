# frozen_string_literal: true

class RanJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.warn '############### I ran ######################'
  end
end
