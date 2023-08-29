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
end
