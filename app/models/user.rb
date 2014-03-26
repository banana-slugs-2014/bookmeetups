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
    f = []
    locations = location.in_range( travel_distance )
    locations.each do |locale|
      locale.users.includes(:books).each do |user|
        next if user == self
        user.books.each do |b|
          f << user if book == b
        end
      end
    end
    f
  end

  def book_friends
    f = []
    books = self.books.to_a
    locations = location.in_range( travel_distance )
    locations.each do |locale|
      locale.users.includes(:books).each do |user|
        next if user == self
        user.books.each do |book|
          f << user if books.include?( book)
        end
      end
    end
    f.uniq
  end
end