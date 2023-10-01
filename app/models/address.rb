# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :house_no, :first_line, :county, :post_code, presence: true, allow_blank: false
end
