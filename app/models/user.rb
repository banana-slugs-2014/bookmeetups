class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, :password, :email, :location_id
  validates_uniqueness_of :username, :email, case_sensitive: false

  has_one :photo
  has_many :favorite_books
  has_many :books, through: :favorite_books
  has_many :user_meetups
  has_many :meetups, through: :user_meetups
  belongs_to :location
  has_many :messages

  def friends(book, miles = 60)
    f = []
    locations = location.in_range( miles )
    locations.each do |locale|
      locale.users.includes(:books).each do |user|
        next if user == self
        user.books.each do |b|
          if book == b
            f << user
          end
        end
      end
    end
    f
  end

  def book_friends(miles = 60)
    f = []
    books = self.books.to_a
    locations = location.in_range( miles )
    locations.each do |locale|
      locale.users.includes(:books).each do |user|
        next if user == self
        user.books.each do |book|
          if books.include?( book)
            f << user
          end
        end
      end
    end
    f.uniq
  end
end