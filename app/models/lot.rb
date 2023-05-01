# frozen_string_literal: true

class Lot < ApplicationRecord
  belongs_to :item
  delegate :owner, to: :item, allow_nil: false
end
