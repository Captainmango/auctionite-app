# frozen_string_literal: true

class AddUploaderIdToPhotos < ActiveRecord::Migration[7.0]
  def change
    change_table :photos do |t|
      t.integer :uploader_id, default: nil
    end

    add_index(:photos, :uploader_id)
  end
end
