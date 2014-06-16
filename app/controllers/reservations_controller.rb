class ReservationsController < ApplicationController
  respond_to :json

  def create
    params.inspect
    begin
      reservation_service = ReservationService.new
      reservation_service.createReservation(params)
    rescue Exception => error
      return render json:{ message: error.message}, status: :unprocessable_entity
    end
    render json: { message: "Reservation created! Booker name: #{params[:booker]}"}
  end

  def index
    begin
      @reservations = Movie.find(params[:movie_id]).shows.find(params[:show_id]).reservations.includes(tickets: [:seat])
    rescue Exception => error
      render json:{ message: error.message}, status: :unprocessable_entity
    end
      render json: @reservations, include: {tickets: {include: :seat}}
  end
end
