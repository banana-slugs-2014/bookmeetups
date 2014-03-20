class Location < ActiveRecord::Base
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  has_many :user_locations
  has_many :users, through :user_locations
end