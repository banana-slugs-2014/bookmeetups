class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.date :date
      t.belongs_to :book
    end
  end
end
