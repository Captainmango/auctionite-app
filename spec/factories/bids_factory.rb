# frozen_string_literal: true

FactoryBot.define do
  transient do
    lot { create(:lot) }
  end

  factory :bid do
    timestamp { '2023-05-02 08:54:17' }
    user_id { lot.item.owner.id }
    lot_id { lot.id }
    amount { 100 }
  end
end
