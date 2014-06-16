class ReservationService

  def createReservation(params)
    params.inspect
    reservation = Reservation.new(params[:reservation].permit(:booker, :user_id))

    show = Show.find(params[:show_id])
    reservation.show = show

    free_seats = show.number_of_free_seats
    reservation_seat_count = params[:tickets].values.sum


    if can_create_reservation(free_seats, reservation_seat_count)
      available_seats = Seat.all_free_for_show(show.id)
      reservation.save

      add_ticket_to_reservation(available_seats, params[:selected], reservation, params[:tickets])
    else
      raise "Cannot book so many tickets! Tickets available : #{free_seats}"
    end
  end

  private
  def can_create_reservation(free_seats, reservation_seat_count)
    free_seats >= reservation_seat_count and reservation_seat_count > 0
  end

  def add_ticket_to_reservation(available_seats, selected, reservation, tickets)
    tickets.each do |ticket_type_id, count|
      ticket_type = TicketType.find(ticket_type_id)
      (1..count).each do
        seat_location = selected.shift
        reservation.tickets << Ticket.new(
            ticket_type: ticket_type,
            seat: available_seats.select { |seat| seat.x == seat_location[:x] && seat.y == seat_location[:y]}.first
        )
      end
    end
  end

end