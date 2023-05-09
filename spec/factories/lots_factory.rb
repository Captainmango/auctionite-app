# frozen_string_literal: true

FactoryBot.define do
  factory :lot do
    transient do
      item { create(:item) }
    end

    user_id { item.owner.id }
    item_id { item.id }
    notes { 'these are some test notes' }

    trait :with_live_dates do
      live_from { Time.current }
      live_to { Time.current + 172_800 } # live for 2 days
    end

    trait :live_in_future do
      live_from { Time.current + 172_800 }
      live_to { Time.current + 360_000 } # live for a bit? Just over a day I reckon
    end

    trait :with_bids do
      after :create do |lot|
        create(:bid, lot:, amount: 100)
        create(:bid, lot:, amount: 150)
      end
    end
  end
end
