# frozen_string_literal: true

class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def sign_in
    respond_to do |format|
      if (@user = login(params[:email], params[:password], params[:remember]))
        format.html { redirect_back_or_to(landing_page_path, notice: 'Login successfull.') }
      else
        format.html do
          flash.now[:alert] = 'Login failed.'
          render action: 'new'
        end
      end
    end
  end

  def sign_out
    logout
  end

  private

  def sign_in_params
    params.permit(:email, :password, :remember)
  end
end
