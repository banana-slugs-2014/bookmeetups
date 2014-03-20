class Book < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :author

  has_many :user_books
  has_many :users, through :user_books
end