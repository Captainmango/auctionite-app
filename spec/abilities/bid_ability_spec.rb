# frozen_string_literal: true

require 'cancan/matchers'
require 'rails_helper'

RSpec.describe BidAbility, type: :ability do
  subject(:ability) { BidAbility.new(user) }
  describe 'Owner of the lot being bid on' do
    let(:lot) { create(:lot, :with_bids) }
    let(:user) { lot.owner }
    let(:bid) { lot.bids.first }

    it { is_expected.to be_able_to(:read, bid) }
    it { is_expected.not_to be_able_to(:update, bid) }
    it { is_expected.not_to be_able_to(:destroy, bid) }
    it { is_expected.not_to be_able_to(:create, create(:bid, user:)) }
  end

  describe 'Not the owner of the lot being bid on' do
    let(:lot) { create(:lot, :with_bids) }
    let(:bid) { lot.bids.first }
    let(:user) { bid.user }

    it { is_expected.to be_able_to(:read, bid) }
    it { is_expected.not_to be_able_to(:update, bid) }
    it { is_expected.not_to be_able_to(:destroy, bid) }
    it { is_expected.to be_able_to(:create, create(:bid, user:)) }
  end
end
