# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\z/i,
    message: 'Must be the correct file type (URL for jpg, gif, png)'
  }
end