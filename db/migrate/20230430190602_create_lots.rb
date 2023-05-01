# frozen_string_literal: true

class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.integer :item_id, null: false, index: { unique: true }
      t.text :notes, default: nil
      t.datetime :live_from, null: true, default: nil
      t.datetime :live_to, null: true, default: nil

      t.datetime :deleted_at, null: true, default: nil
      t.timestamps
    end
  end
end
