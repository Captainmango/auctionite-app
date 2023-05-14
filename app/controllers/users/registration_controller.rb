# frozen_string_literal: true

module Users
  class RegistrationController < ApplicationController
    def new
      @user = User.new
    end

    def register
      @user = User.new(new_user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to landing_page_path, success: 'Account created successfully' }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    private

    def new_user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
