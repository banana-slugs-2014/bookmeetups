class Message < ActiveRecord::Base
  attr_accessible :text
  belongs_to :meetup
end