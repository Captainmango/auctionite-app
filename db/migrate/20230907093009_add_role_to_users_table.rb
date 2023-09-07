# frozen_string_literal: true

class AddRoleToUsersTable < ActiveRecord::Migration[7.0]
  def change
    change_table(:users) do |t|
      t.column :role, :string, null: true
    end
  end
end
