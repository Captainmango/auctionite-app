# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompleteAuctionsJob, type: :job do
  it 'completes auctions that have end dates in the past' do
    auctions = create_list(:lot, 5, :with_live_dates_in_past)

    CompleteAuctionsJob.perform_now

    auctions.each do |auction|
      expect(auction.reload.completed?).to be_truthy
    end
  end

  it 'ignores auctions that are ongoing' do
    auctions = create_list(:lot, 5, :with_live_dates)

    CompleteAuctionsJob.perform_now

    auctions.each do |auction|
      expect(auction.reload.completed?).to be_falsey
    end
  end

  it 'ignores auctions that are terminated' do
    auctions = create_list(:lot, 5, :with_live_dates, status: 'terminated')

    CompleteAuctionsJob.perform_now

    auctions.each do |auction|
      expect(auction.reload.completed?).to be_falsey
    end
  end
end
