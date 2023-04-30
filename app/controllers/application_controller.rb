# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Sorcery::Controller::InstanceMethods

  def not_authenticated
    redirect_to landing_page_path
    flash[:notice] = 'Please log in to access this resource'
  end
end
