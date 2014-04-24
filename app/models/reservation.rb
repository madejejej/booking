# TODO: validates booker/user_id presence
class Reservation < ActiveRecord::Base
  has_many :seats, through: :reservation_seats

  has_many :reservation_seats

end
