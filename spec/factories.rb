FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| Faker::Lorem.word + n.to_s }
    password Faker::Lorem.word
    email Faker::Internet.email
  end

  factory :book do
    title Faker::Lorem.word
    author Faker::Name.name
    isbn Faker::Number.number(13)
    google_id Faker::Number.number(15)
  end

end