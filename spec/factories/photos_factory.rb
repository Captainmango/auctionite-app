# frozen_string_literal: true

FactoryBot.define do
  factory :photo do
    association :imageable, factory: :item
    sequence(:url) { |n| "pic_#{n}.jpg" }
  end
end
