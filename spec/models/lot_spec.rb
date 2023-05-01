# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lot, type: :model do
  it 'has an owner' do
    lot = create(:lot)
    expect(lot.owner).not_to be_nil
  end

  it 'only returns live when scope is used' do
    create(:lot, :live_in_future)
    expect(Lot.live.count).to be_equal(0)
  end
end
