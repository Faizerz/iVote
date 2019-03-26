# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :user_type, default: "free"
      t.integer :score, default: 10
      t.string :email, null: false
      t.timestamps null: false
    end
  end
end
