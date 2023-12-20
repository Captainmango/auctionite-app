# frozen_string_literal: true

class AuctionCompleteMailer < ApplicationMailer
  def winner_email(user, item)
    @user = user
    @item = item

    mail(to: user.email, from: 'testadmin@test.com') do |format|
      format.text
      format.mjml
    end
  end

  def owner_email(user, item)
    @user = user
    @item = item

    mail(to: user.email, from: 'testadmin@test.com') do |format|
      format.text
      format.mjml
    end
  end
end
