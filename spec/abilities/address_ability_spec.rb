# frozen_string_literal: true

require 'cancan/matchers'
require 'rails_helper'

RSpec.describe AddressAbility, type: :ability do
  subject(:ability) { AddressAbility.new(user) }
  describe 'Is the owner of an address' do
    let(:user) { create(:user) }
    let(:address) { create(:address, addressable_id: user.id) }

    it { is_expected.to be_able_to(:read, address) }
    it { is_expected.to be_able_to(:update, address) }
    it { is_expected.to be_able_to(:destroy, address) }
  end

  describe 'Is NOT the owner of an address' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:address) { create(:address, addressable_id: other_user.id) }

    it { is_expected.to be_able_to(:read, address) }
    it { is_expected.not_to be_able_to(:update, address) }
    it { is_expected.not_to be_able_to(:destroy, address) }
  end
end
