# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'has photos' do
    item = create(:item, :with_photos, photo_count: 2)
    expect(item.photos.count).to be(2)
  end
end
