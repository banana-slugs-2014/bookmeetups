class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :title, null: false
      t.text :author, null: false
      t.string :isbn, null: false, unique: true
      t.string :google_id, unique: true
    end
  end
end
