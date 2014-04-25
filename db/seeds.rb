# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# ruby encoding: utf-8



screen1 = Screen.create!(name: "Multikino sala 2")

cinema1 = Cinema.create(name: "Multikino", location: "Kraków", phone: "123456789")
cinema1.screens << screen1

showType = ShowType.create(name: "Normalny")
cinema1.show_types << showType

ticketType1 = TicketType.create(name: "Normalny", price_in_eurocents: 11, show_type: showType)

screen1 = Screen.create!(name: 'Multikino sala 1')
screen2 = Screen.create!(name: 'Multikino sala 2')

cinema1 = Cinema.create(name: 'Multikino', location: 'Kraków', phone: '123456789')
cinema1.screens << screen1
cinema1.screens << screen2

showType = ShowType.create(name: 'Standard')
cinema1.show_types << showType

ticketType1 =TicketType.create(name: 'Normalny', price_in_eurocents: 11, show_type: showType)
TicketType.create(name: 'Ulgowy', price_in_eurocents: 8, show_type: showType)

matrix = Movie.create!(title: 'Matrix', description: 'Super Neo fighting and flying!', cover_url: 'assets/movies_covers/matrix.jpg', director: 'Andy Wachowski Lana Wachowski', duration: 120)

matrix2 = Movie.create!(title: 'Matrix 2', description: 'Super Neo fighting and flying even more!', cover_url: 'assets/movies_covers/matrix2.jpg', director: 'Andy Wachowski Lana Wachowski', duration: 96)


5.times do |i|
  matrix.shows << Show.new(date: DateTime.now + i.hours, screen: screen1, show_type: showType)

  matrix2.shows << Show.new(date: DateTime.now + (1+i).hours, screen: screen1, show_type: showType)
end

20.times do
  screen1.seats << Seat.new()
  screen2.seats << Seat.new()
end

reservation = Reservation.create(show: matrix.shows.first())
reservation.tickets << Ticket.new(ticket_type: ticketType1,seat: screen1.seats.first())
