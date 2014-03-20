require 'spec_helper'

FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| Faker::Lorem.word + n.to_s }
    password Faker::Lorem.word
    email Faker::Internet.email
  end

end