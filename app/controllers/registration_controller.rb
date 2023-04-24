# frozen_string_literal: true

class RegistrationController < ApplicationController
  def new; end

  def register
    @user = User.new(new_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, success: 'Account created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def new_user_params
    params.permit(:email, :password)
  end
end
