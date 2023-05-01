# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@test#{n}.com" }
    password { 'password' }

    trait :with_item_photos do
      transient do
        photo_count { 1 }
      end

      after(:create) do |user, eval|
        item = create(:item, owner: user)
        create_list(:photo, eval.photo_count, imageable_id: item.id, imageable_type: 'Item', uploader_id: user.id)
      end
    end
  end
end
