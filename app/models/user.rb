class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, :password, :email
  validates_uniqueness_of :username, :email, :case_sensative: false

  has_many :user_books
  has_many :books, through: :user_books
end