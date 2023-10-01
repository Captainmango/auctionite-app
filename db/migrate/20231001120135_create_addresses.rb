# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :house_no, null: false
      t.string :first_line, null: false
      t.string :second_line
      t.string :county, null: false
      t.string :post_code, null: false
      t.string :addressable_type, null: false
      t.integer :addressable_id, null: false
      t.timestamps
    end
  end
end
