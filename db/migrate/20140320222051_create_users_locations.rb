class CreateUsersLocations < ActiveRecord::Migration
  def change
    create_table :users_locations do |t|
      t.belongs_to :user
      t.belongs_to :location
    end
  end

end
