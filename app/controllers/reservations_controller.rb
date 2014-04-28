class ReservationsController < ApplicationController
  respond_to :json

  def create
    begin
      reservation_service = ReservationService.new
      reservation_service.createReservation(params)
    rescue Exception => error
      return render json:{ message: error.message}, status: :unprocessable_entity
    end
    render json: { message: "Reservation created! Booker name: #{params[:booker]}"}
  end
end
