# frozen_string_literal: true

class AuctionCompleteMailer < ApplicationMailer
  def winner_email(user)
    @user = user

    mail(to: user.email, from: 'testadmin@test.com') do |format|
      format.text
      format.mjml
    end
  end
end
