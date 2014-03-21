class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
    end
  end
end
