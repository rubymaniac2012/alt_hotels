# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    hotel
    room_type { %w[Standard Executive].sample }
    price { 1500.00 }
    max_guests { rand(2..4) }
  end
end
