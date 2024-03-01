# frozen_string_literal: true

FactoryBot.define do
  factory :hotel do
    name { Faker::Name.name }
    city { Faker::Address.city }
    contact { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
  end
end
