require "rails_helper"

RSpec.describe ReservationsController, type: :routing do
  describe "routing" do
    let!(:hotel) { FactoryBot.create(:hotel) }

    it "routes to #new" do
      expect(get: "hotels/#{hotel.id}/reservations/new").to route_to("reservations#new", hotel_id: hotel.id.to_s)
    end

    it "routes to #show" do
      expect(get: "hotels/#{hotel.id}/reservations/1").to route_to("reservations#show", id: "1", hotel_id: hotel.id.to_s)
    end

    it "routes to #edit" do
      expect(get: "hotels/#{hotel.id}/reservations/1/edit").to route_to("reservations#edit", id: "1", hotel_id: hotel.id.to_s)
    end

    it "routes to #create" do
      expect(post: "hotels/#{hotel.id}/reservations").to route_to("reservations#create", hotel_id: hotel.id.to_s)
    end

    it "routes to #update via PUT" do
      expect(put: "hotels/#{hotel.id}/reservations/1").to route_to("reservations#update", id: "1", hotel_id: hotel.id.to_s)
    end

    it "routes to #update via PATCH" do
      expect(patch: "hotels/#{hotel.id}/reservations/1").to route_to("reservations#update", id: "1", hotel_id: hotel.id.to_s)
    end

    it "routes to #destroy" do
      expect(delete: "hotels/#{hotel.id}/reservations/1").to route_to("reservations#destroy", id: "1", hotel_id: hotel.id.to_s)
    end
  end
end
