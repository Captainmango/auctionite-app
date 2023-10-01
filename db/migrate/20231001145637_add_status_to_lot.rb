# frozen_string_literal: true

class AddStatusToLot < ActiveRecord::Migration[7.0]
  def change
    change_table(:lots) do |t|
      t.string :status, null: true
    end
  end
end
