# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'it being composed of money' do
    it 'has a composed of money relation' do
      item = create(:item)
      expect(item.money).to be_an_instance_of(ValueObjects::Money)
    end

    it 'has the amount being read out correctly' do
      item = create(:item, starting_price: 4500)
      expect(item.money.amount).to eq(45.00)
    end

    it 'can have money set to the accessor without issue' do
      item = create(:item)
      new_money = ValueObjects::Money.from_human(12.00)
      item.money = new_money
      item.save

      expect(item.money.amount).to eq(12.00)
    end
  end
end
