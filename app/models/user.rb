# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :items, dependent: :destroy
end
