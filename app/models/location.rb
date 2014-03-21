class Location < ActiveRecord::Base
  attr_accessible :city, :state, :zip
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  has_many :users
  geocoded_by :address
  after_validation :geocode


  def address
    [city, state, zip].compact.join(', ')
  end
end