# frozen_string_literal: true

require 'cancan/matchers'
require 'rails_helper'

RSpec.describe LotAbility, type: :ability do
  subject(:ability) { LotAbility.new(user) }
  describe 'Not the owner of any lots' do
    let(:user) { create(:user) }
    let(:lot) { create(:lot, :with_live_dates) }

    it { is_expected.to be_able_to(:read, lot) }
    it { is_expected.not_to be_able_to(:update, lot) }
    it { is_expected.not_to be_able_to(:destroy, lot) }
  end

  describe 'Owner of a lot' do
    let(:user) { create(:user) }
    let(:lot) { create(:lot, :live_in_future, owner: user) }

    it { is_expected.to be_able_to(:read, lot) }
    it { is_expected.to be_able_to(:update, lot) }
    it { is_expected.to be_able_to(:destroy, lot) }
  end
end
