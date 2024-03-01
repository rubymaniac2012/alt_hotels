# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Hyderabad city
hotels = %w[Hyderabad Delhi Bengaluru Mumbai Chennai Kolkata]
rand(10..20).times do
	hotel = Hotel.create(name: Faker::Name.name, city: hotels.sample, contact: Faker::PhoneNumber.phone_number, email: Faker::Internet.email)
	%w[Standard Executive].each do |room_type|
		price = room_type == 'Standard' ? 1499.99 : 2499.99
		Room.create(room_type: room_type, price: price, description: 'Test description', max_guests: [2,4].sample, hotel_id: hotel.id)
	end
end

User.create(name: Faker::Name.name, email: Faker::Internet.email)

