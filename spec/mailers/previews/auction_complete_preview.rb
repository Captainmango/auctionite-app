# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/auction_complete
class AuctionCompletePreview < ActionMailer::Preview
  def winner_email
    user = User.first
    item = Item.first
    AuctionCompleteMailer.winner_email(user, item)
  end

  def owner_email
    user = User.first
    item = Item.first
    AuctionCompleteMailer.owner_email(user, item)
  end

  def winner_email_no_address
    user = User.first
    item = Item.first
    AuctionCompleteMailer.winner_email_no_address(user, item)
  end

  def owner_email_winner_no_address
    user = User.first
    item = Item.first
    AuctionCompleteMailer.owner_email_winner_no_address(user, item)
  end
end
