class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :password_digest, null: false
      t.integer :unread, default: 0
      t.string :email, null: false, unique: true
      t.belongs_to :location
    end
  end
end
