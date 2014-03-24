class Meetup < ActiveRecord::Base
  has_many :user_meetups
  has_many :users, through: :user_meetups
  has_many :messages
  belongs_to :book

  # Eh, the name of this makes me thing that a Meetup can be "unread" and
  # that's just crazy.  Suggest rename method.  a_meetup#mark_messages_read
  # or #unread_messages_count

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
