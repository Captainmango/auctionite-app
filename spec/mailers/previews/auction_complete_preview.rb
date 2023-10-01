# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/auction_complete
class AuctionCompletePreview < ActionMailer::Preview
  def winner_email
    user = User.first
    AuctionCompleteMailer.winner_email(user)
  end
end
