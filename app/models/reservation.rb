class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :user
  belongs_to :room

  before_create :set_status

  before_save :calculate_price

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :rooms, presence: true
  validate :checked_in_dates

  scope :active, -> { where("status = 'booked' and check_out >= #{Date.today}") }

  def destroy!
    update(status: 'cancel')
  end

  private

  def set_status
    return if status

    self.status = 'booked'
  end

  def calculate_price
    self.price = room.price * rooms * (check_out - check_in).to_i
  end

  def checked_in_dates
    errors.add(:check_in, "can't be a past date") if check_in&.before?(Date.today)
    errors.add(:check_in, "can't be after checkout") if check_out.present? && check_in&.after?(check_out)
  end
end
