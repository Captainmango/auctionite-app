# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    user_id { FactoryBot.create(:user).id }
    sequence(:name) { |n| "Item #{n}" }
    description { 'This is a test item.' }
    starting_price { rand(1..90) }

    trait :without_starting_price do
      starting_price { nil }
    end

    trait :with_main_photo do
      after :create do |item|
        item.main_image.attach(io: File.open(Rails.root.join('spec/support/stock_images/test_image_1.jpg')),
                               filename: 'test_image_1.jpg',
                               content_type: 'image/jpeg')
      end
    end
  end
end
