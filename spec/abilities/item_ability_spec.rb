# frozen_string_literal: true

require 'cancan/matchers'
require 'rails_helper'

RSpec.describe ItemAbility, type: :ability do
  subject(:ability) { ItemAbility.new(user) }
  describe 'Owner of the item not in a lot' do
    let(:item) { create(:item) }
    let(:user) { item.owner }

    it { is_expected.to be_able_to(:read, item) }
    it { is_expected.to be_able_to(:update, item) }
    it { is_expected.to be_able_to(:destroy, item) }
    it { is_expected.to be_able_to(:create, item) }
  end

  describe 'Owner of the item in a lot that isn\'t live' do
    let(:item) { create(:item) }
    let(:lot) { create(:lot, item:) }
    let(:user) { item.owner }

    it { is_expected.to be_able_to(:read, item) }
    it { is_expected.to be_able_to(:update, item) }
    it { is_expected.to be_able_to(:destroy, item) }
    it { is_expected.to be_able_to(:create, item) }
  end

  describe 'Owner of the item in a lot that is live' do
    let(:lot) { create(:lot, :with_live_dates) }
    let(:item) { lot.item }
    let(:user) { item.owner }

    it { is_expected.to be_able_to(:read, item) }
    it { is_expected.not_to be_able_to(:update, item) }
    it { is_expected.not_to be_able_to(:destroy, item) }
    it { is_expected.to be_able_to(:create, item) }
  end
end
