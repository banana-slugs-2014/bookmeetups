class Book < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :isbn
  validates_uniqueness_of :isbn
  validates_uniqueness_of :google_id
  validates_uniqueness_of :author, :scope => :title

  validates :isbn, format: { with: /^\d{13}$/ }

  has_many :user_books
  has_many :users, through: :user_books
  has_many :meetups

  def photo_link( zoom = 2)
    # I might recommend extracting this
    #
    # PhotoLinkGenerator.new(self.google_id, 3).photo_link
    "http://bks7.books.google.com/books?id=#{google_id}&printsec=frontcover&img=1&zoom=#{zoom}"
  end
end

=begin comment
class PhotoLinkGenerator
  PICTURE_URI = "http://bks7.books.google.com/books?id=%s&printsec=frontcover&img=1&zoom=%s"

  def initialize(google_id, opts={:zoom_factor})
    @google_id = google_id
    @zoom_factor opts[:zoom_factor] || 2
  end

  def photo_link
    sprintf(PICTURE_URI, @google_id, @zoom_factor)
  end
end
=end
