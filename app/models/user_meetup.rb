# makes much more sense than a UserBook
class UserMeetup < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup
end
