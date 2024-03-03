class HotelsController < ApplicationController
  before_action :set_hotel, only: :show

  def index
    @hotels = Hotel.includes(:rooms).where('city = ?', params[:search])
    respond_to do |format|
      format.js {}
    end
  end

  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def hotel_params
    params.fetch(:hotel, {})
  end
end
