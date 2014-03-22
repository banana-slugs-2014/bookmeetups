class Meetup < ActiveRecord::Base
  has_many :user_meetups
  has_many :users, through: :user_meetups
  has_many :messages
  belongs_to :book
end