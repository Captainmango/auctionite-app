# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    house_no { rand(1..100) }
    first_line { 'Mycroft street' }
    county { 'Frogbrookshire' }
    post_code { 'WF55 2WE' }
    addressable_type { 'User' }
    addressable_id { create(:user).id }
  end
end
