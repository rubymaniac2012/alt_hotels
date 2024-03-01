class User < ApplicationRecord
	has_many :reservations

	validates :email, uniqueness: true

	def upcoming_reservations
		reservations.where("check_in >= ? and status = 'booked'", Date.today).order(:check_in)
	end

	def ongoing_reservations
		reservations.where("check_in < ? and check_out >= ? and status = 'booked'", Date.today, Date.today).order(:check_in)
	end
end
