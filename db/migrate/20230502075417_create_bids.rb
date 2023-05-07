# frozen_string_literal: true

class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.datetime :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :user_id, null: false, index: true
      t.integer :lot_id, null: false, index: true
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
