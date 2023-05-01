# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lot, type: :model do
  it 'has an owner' do
    lot = create(:lot)
    expect(lot.owner).not_to be_nil
  end
end
