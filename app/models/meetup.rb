class Meetup < ActiveRecord::Base
  has_many :user_meetups
  has_many :users, through: :user_meetups
  has_many :messages
  belongs_to :book

  def unread(u_id)
    num = 0
    messages.each do |message|
      num += 1   if message.user_id != u_id && message.unread
    end
    num
  end

  def mark_read(u_id)
    messages.each do |message|
      unless message.user_id == u_id
        message.unread = false
        message.save
      end 
    end
  end
end