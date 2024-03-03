class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy]
  before_action :set_hotel

  def show; end

  def new
    @reservation = @hotel.reservations.build(room_id: params[:room_id])
  end

  def edit; end

  def create
    @reservation = @hotel.reservations.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to root_path, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to root_path, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Reservation was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_hotel
    @hotel = Hotel.find_by(id: params[:hotel_id]) || @reservation&.hotel
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :name, :email, :guests, :rooms, :room_id, :user_id)
  end
end
