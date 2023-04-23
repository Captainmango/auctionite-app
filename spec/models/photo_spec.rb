# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  it 'users own items with photos' do
    user = create(:user, :with_item_photos)
    expect(user.uploaded_photos.count).to be(1)
    expect(user.items.count).to be(1)
    expect(user.items.first.photos.count).to be(1)
  end
end
