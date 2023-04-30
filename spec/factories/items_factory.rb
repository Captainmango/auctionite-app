# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    user_id { FactoryBot.create(:user).id }
    sequence(:name) { |n| "Item #{n}" }
    description { 'This is a test item.' }
    starting_price { rand(1..90) }

    trait :with_photos do
      transient do
        photo_count { 1 }
      end

      after(:create) do |item, eval|
        create_list(:photo, eval.photo_count, imageable_id: item.id, imageable_type: 'Item')
        item.reload
      end
    end

    trait :without_starting_price do
      starting_price { nil }
    end
  end
end
