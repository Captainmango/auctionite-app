# frozen_string_literal: true

FactoryBot.define do
  factory :bid do
    transient do
      lot { create(:lot) }
      user { create(:user) }
    end

    timestamp { Time.current }
    user_id { user.id }
    lot_id { lot.id }
    amount { 100 }
  end
end
