# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    hotel
    user
    room
    name { Faker::Name.name }
    status { 'booked' }
    guests { rand(1..4) }
    rooms { rand(1..2) }
    check_in { Date.today }
    check_out { Date.tomorrow }
    email { Faker::Internet.email }
  end

  trait :cancel do
    status { 'cancel' }
  end

  trait :completed do
    status { 'completed' }
  end
end
