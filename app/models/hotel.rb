class Hotel < ApplicationRecord
	has_many :rooms
	has_many :reservations

	validates :name, uniqueness: { scope: :city }
end
