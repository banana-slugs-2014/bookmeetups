class Book < ActiveRecord::Base
  validates_presence_of :title, :author, :isbn
  validates_uniqueness_of :isbn, :google_id
  validates_uniqueness_of :author, :scope => :title

  validates :isbn, format: { with: /^\d{13}$/ }

  has_many :favorite_books
  has_many :users, through: :favorite_books
  has_many :meetups

  def photo_link( zoom = 2)
    "http://bks7.books.google.com/books?id=#{google_id}&printsec=frontcover&img=1&zoom=#{zoom}"
  end
end
