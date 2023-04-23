# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description
      t.integer :starting_price
      t.integer :user_id, index: true, null: false

      t.timestamps
    end
  end
end
