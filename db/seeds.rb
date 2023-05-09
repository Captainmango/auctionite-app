# frozen_string_literal: true

# Seeds lots with items and owning users that are live without bids
FactoryBot.create_list(:lot, 3, :with_live_dates) # user_id 1-3

# Seeds items and owning users that can be assigned to lots
FactoryBot.create_list(:item, 3) # user_id 4-6

# Seeds lots with items and owning users that are live that have bids
FactoryBot.create_list(:lot, 3, :with_live_dates, :with_bids) # user_id 7-10
