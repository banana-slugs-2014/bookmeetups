class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, :password, :email
  validates_uniqueness_of :username, :email, case_sensitive: false

  has_one :photo
  has_many :user_books
  has_many :books, through: :user_books
  has_many :user_meetups
  has_many :meetups, through: :user_meetups
  belongs_to :location
  has_many :messages


  def book_friends(miles = 60)
    friends = []
    books = self.books.to_a
    locations = location.in_range( miles )
    locations.each do |locale|
      locale.users.includes(:books).each do |user|
        next if user == self
        user.books.each do |book|
          if books.include?( book)
            friends << user
          end
        end
      end
    end
    friends.uniq
  end
end