# frozen_string_literal: true

FactoryBot.define do
  factory :photo do
    association :imageable, factory: :item
    association :uploader, factory: :user
    sequence(:url) { |n| "pic_#{n}.jpg" }
  end
end
