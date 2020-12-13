# frozen_string_literal: true

# Migration to add users table
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :nickname
      t.string :password_digest

      t.timestamps
    end
  end
end
