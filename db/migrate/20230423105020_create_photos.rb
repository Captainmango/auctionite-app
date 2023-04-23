# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :imageable_type, null: false
      t.integer :imageable_id, null: false
      t.string :url

      t.timestamps
    end

    add_index :photos, %i[imageable_type imageable_id]
  end
end
