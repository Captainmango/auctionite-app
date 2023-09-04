# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/reset_password
class ResetPasswordPreview < ActionMailer::Preview
  def reset_password_email
    user = User.find(1)
    ResetPasswordMailer.reset_password_email(user)
  end
end
