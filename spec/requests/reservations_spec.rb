require 'rails_helper'

RSpec.describe "/reservations", type: :request do
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:room) { FactoryBot.create(:room, hotel: hotel) }
  let(:user) { FactoryBot.create(:user) }
  let(:reservation) { FactoryBot.create(:reservation) }
  let(:valid_attributes) { FactoryBot.attributes_for(:reservation).merge(user_id: user.id, room_id: room.id) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:reservation).merge(user_id: user.id, room_id: room.id, check_in: Date.today + rand(2..5)) }

  describe "GET /show" do
    it "renders a successful response" do
      get hotel_reservation_url(reservation.hotel, reservation)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_hotel_reservation_url(hotel.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_hotel_reservation_url(reservation.hotel, reservation)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Reservation" do
        expect {
          post hotel_reservations_url(hotel_id: hotel.id), params: { reservation: valid_attributes }
        }.to change(Reservation, :count).by(1)
      end

      it "redirects to the root page" do
        post hotel_reservations_url(hotel_id: hotel.id), params: { reservation: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Reservation" do
        expect {
          post hotel_reservations_url(hotel_id: hotel.id), params: { reservation: invalid_attributes }
        }.to change(Reservation, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post hotel_reservations_url(hotel_id: hotel.id), params: { reservation: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:valid_check_out) { Date.today + rand(4..10) }

      before { patch hotel_reservation_url(reservation.hotel, reservation), params: { reservation: { check_out: valid_check_out } } }

      it "updates the requested reservation" do
        expect(reservation.reload.check_out).to eq(valid_check_out)
      end

      it "redirects to the reservation" do
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      let(:invalid_check_out) { Date.today - rand(4..10) }

      before { patch hotel_reservation_url(reservation.hotel, reservation), params: { reservation: { check_out: invalid_check_out } } }

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # This just updates the status to 'cancel'. It's not hard delete
  describe "DELETE /destroy" do
    it "destroys the requested reservation" do
      reservation
      expect {
        delete hotel_reservation_url(reservation.hotel, reservation)
      }.to change(Reservation.active, :count).by(-1)
    end

    it "redirects to the reservations list" do
      delete hotel_reservation_url(reservation.hotel, reservation)
      expect(response).to redirect_to(root_url)
    end
  end
end
