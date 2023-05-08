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
  end
end
