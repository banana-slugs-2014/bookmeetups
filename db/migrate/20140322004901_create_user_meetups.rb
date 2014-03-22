class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_table :user_meetups do |t|
      t.belongs_to :user
      t.belongs_to :meetup
    end
  end
end
