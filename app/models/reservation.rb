# TODO: validates booker/user_id presence
class Reservation < ActiveRecord::Base
  has_many :seats, through: :reservation_seat

end
