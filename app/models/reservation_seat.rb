class ReservationSeat < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :seat, class_name: Movie::Screen::Seat

  validates :reservation, presence: true
  validates :seat, presence: true
end
