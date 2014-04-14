class ReservationsController < ApplicationController

  def create
    reservation = Reservation.new(params[:reservation].permit( :booker, :user_id))
    reservation.show_id = params[:show_id]

    show = Show.find(params[:show_id])
    show.number_of_free_seats()
    #if @reservation.show.screen.seats. @reservation.seats.count <

  end

end
