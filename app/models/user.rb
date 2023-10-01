# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, :password, presence: true
  validates :password, length: { in: 6..35 }
  enum(:role, {
         user: 'user',
         admin: 'admin'
       }, default: :user)

  has_many :items, dependent: :destroy
  has_many :lots, through: :items
  has_many :bids, dependent: nil
  has_one :address, as: :addressable, dependent: nil
end
