class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, :password_digest, :email, :location_id
  validates_uniqueness_of :username, :email, case_sensitive: false

  has_one :photo
  has_many :favorite_books
  has_many :books, through: :favorite_books
  has_many :user_meetups
  has_many :meetups, through: :user_meetups
  belongs_to :location
  has_many :messages

  def new_unread_message
    self.unread += 1
    self.save
  end

  def friends(book)
    location.locations_within_range( travel_distance ).each_with_object([]) do |locale, coll |
      coll << friends_at_location( locale, [book] )
    end.flatten
  end

  def book_friends
    b= self.books.to_a
    location.locations_within_range( travel_distance ).each_with_object([]) do |locale, coll |
      coll << friends_at_location( locale, b )
    end.flatten
  end

  def friends_at_location( location, books )
    location.users.includes(:books).select do |user|
      user if user != self &&
      user.books.any?{ |users_book| books.include?( users_book ) }
    end
  end
end