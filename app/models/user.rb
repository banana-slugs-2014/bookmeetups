class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, :password, :email
  validates_uniqueness_of :username, :email, case_sensitive: false

  has_many :user_books
  has_many :books, through: :user_books
  has_many :user_meetups
  has_many :meetups, through: :user_meetups
  belongs_to :location


  def find_book_freinds()
    friends = []
    books = self.books.to_a
    self.location.users.includes(:books).each do |user|
      next if user == self
      user.books.each do |book|
        if books.include?( book)
          friends << user
        end
      end
    end
    friends.uniq
  end

  def extended_location

  end
end