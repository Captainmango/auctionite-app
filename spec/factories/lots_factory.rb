# frozen_string_literal: true

FactoryBot.define do
  factory :lot do
    item_id { create(:item).id }
    notes { 'these are some test notes' }

    trait :with_live_dates do
      live_from { Time.current }
      live_to { Time.current + 172_800 } # live for 2 days
    end
  end
end
