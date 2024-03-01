require 'rails_helper'

RSpec.describe Reservation, type: :model do

  describe '#associations' do
    it { is_expected.to(belong_to(:hotel)) }
    it { is_expected.to(belong_to(:user)) }
    it { is_expected.to(belong_to(:room)) }
  end

  describe '#validations' do
    subject { FactoryBot.build(:reservation) }

    it { is_expected.to(validate_presence_of(:check_in)) }
    it { is_expected.to(validate_presence_of(:check_out)) }
    it { is_expected.to(validate_presence_of(:rooms)) }
  end

  describe '#scope' do
    let!(:cancelled_reservation) { FactoryBot.create(:reservation, :cancel) }
    let!(:completed_reservation) { FactoryBot.create(:reservation, :completed) }
    let!(:active_reservation) { FactoryBot.create(:reservation) }

    it 'active reservations do not include cancel reservation' do
      expect(Reservation.active).not_to include(cancelled_reservation)
    end

    it 'active reservations do not include completed reservation' do
      expect(Reservation.active).not_to include(completed_reservation)
    end

    it 'active reservations do include active reservation' do
      expect(Reservation.active).to include(active_reservation)
    end
  end

  describe '#before_save' do
    let(:reservation) { FactoryBot.build(:reservation) }

    it 'calculates the total amount' do
      expect(reservation.price).to be_nil

      reservation.save
      reservation.reload
      expect(reservation.reload.price).not_to be_nil
    end
  end
end
