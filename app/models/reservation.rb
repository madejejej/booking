# TODO: validates booker/user_id presence
class Reservation < ActiveRecord::Base
  has_many :seats, through: :tickets
  has_many :tickets
end
