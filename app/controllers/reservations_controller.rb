class ReservationsController < ApplicationController
  respond_to :json

  def create
    reservation = Reservation.new(params[:reservation].permit(:booker, :user_id))

    show = Show.find(params[:show_id])
    reservation.show = show

    free_seats = show.number_of_free_seats
    reservation_seat_count = params[:tickets].values.sum


    if can_create_reservation(free_seats, reservation_seat_count)
      available_seats = Seat.all_free_for_show(show.id)
      reservation.save

      add_ticket_to_reservation(available_seats, reservation,params[:tickets])
    else
      return render json:{ message: "Cannot book so many tickets! Tickets available : #{free_seats}"}
    end
    render json:{ message: 'Reservation created!'}
  end

  def can_create_reservation(free_seats, reservation_seat_count)
    free_seats >= reservation_seat_count and reservation_seat_count > 0
  end

  def add_ticket_to_reservation(available_seats, reservation, tickets)
    tickets.each do |ticket_type_id, count|
      ticket_type = TicketType.find(ticket_type_id)
      (1..count).each do
        reservation.tickets << Ticket.new(ticket_type: ticket_type, seat: available_seats.shift)
      end
    end
  end

end
