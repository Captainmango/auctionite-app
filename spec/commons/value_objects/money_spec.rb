# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Money', type: :value_object do
  describe 'creating money' do
    it 'it can handle float' do
      money = ValueObjects::Money.from_human(12.34)
      expect(money.amount).to eq(12.34)
    end

    it 'it can handle integer' do
      money = ValueObjects::Money.from_human(12)
      expect(money.amount).to eq(12.00)
    end

    it 'it does not handle strings' do
      expect { ValueObjects::Money.from_human('abc') }.to raise_error
    end
  end

  describe 'reading money' do
    it 'presents money to 2 decimal places' do
      money = ValueObjects::Money.from_human(12.001)
      expect(money.amount).not_to eq(12.001)
    end
  end

  describe 'comparing money' do
    it 'can see 2 moneys are equal in value' do
      m1 = ValueObjects::Money.new(1234)
      m2 = ValueObjects::Money.new(1234)

      expect(m1 == m2).to be_truthy
    end

    it 'can see that one money is more than another' do
      m1 = ValueObjects::Money.new(1234)
      m2 = ValueObjects::Money.new(4321)

      expect(m1 <= m2).to be_truthy
    end
  end
end
