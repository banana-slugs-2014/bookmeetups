class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, :password, :email
  validates_uniqueness_of :username, :email, case_sensitive: false

  has_many :user_books
  has_many :books, through: :user_books
  has_many :user_meetups
  has_many :meetups, through: :user_meetups
  belongs_to :location
end