# frozen_string_literal: true

class SorceryRememberMe < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :remember_me_token, default: nil
      t.datetime :remember_me_token_expires_at, default: nil
    end

    add_index :users, :remember_me_token
  end
end
