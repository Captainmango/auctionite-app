# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Sorcery::Controller::InstanceMethods

  def route_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  def not_authenticated
    redirect_to landing_page_path
    flash[:notice] = 'Please log in to access this resource'
  end
end
