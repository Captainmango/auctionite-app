# frozen_string_literal: true

class ResetPasswordMailer < ApplicationMailer
  def reset_password_email(user)
    mail(to: user.email, from: 'testadmin@test.com') do |format|
      format.text
      format.mjml
    end
  end
end
