# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, :password, presence: true
  validates :password, length: { maximum: 35 }

  has_many :items, dependent: :destroy
  has_many :uploaded_photos, inverse_of: 'uploader', class_name: 'Photo',
                             foreign_key: 'uploader_id', dependent: :nullify
end
