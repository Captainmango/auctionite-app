# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bid, type: :model do
  context 'It being composed of money' do
    it 'has a composed of money relation' do
      bid = create(:bid)
      expect(bid.money).to be_an_instance_of(ValueObjects::Money)
    end

    it 'has the amount being read out correctly' do
      bid = create(:bid, amount: 4500)
      expect(bid.money.amount).to eq(45.00)
    end

    it 'can have money set to the accessor without issue' do
      bid = create(:bid)
      new_money = ValueObjects::Money.from_human(12.00)
      bid.money = new_money
      bid.save

      expect(bid.money.amount).to eq(12.00)
    end
  end
end
