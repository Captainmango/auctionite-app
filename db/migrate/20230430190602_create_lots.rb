# frozen_string_literal: true

class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.integer :item_id, null: false
      t.text :notes

      t.datetime :deleted_at, null: true, default: nil
      t.timestamps
    end
  end
end
