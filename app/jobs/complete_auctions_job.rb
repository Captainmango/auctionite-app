# frozen_string_literal: true

class CompleteAuctionsJob < ApplicationJob
  queue_as :default

  def perform
    auctions = Lot.complete

    auctions.each do |auction|
      auction.domain_tap(&:complete)
    end
  end
end
