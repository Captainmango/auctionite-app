# frozen_string_literal: true

json.extract! lot, :id, :created_at, :updated_at
json.url lot_url(lot, format: :json)
