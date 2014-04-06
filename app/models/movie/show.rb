class Movie::Show < ActiveRecord::Base
  belongs_to :movie, inverse_of: :shows
  belongs_to :screen, class_name: Movie::Screen
  has_many :reservations


  validates :movie, presence: true
  validates :screen, presence: true

  def number_of_free_seats
    all_seats_count = screen.seats.count



    reservation_ids = reservations.map {|reservation| reservation.reservation_id}
    occupied_seats = reservations.includes(:seats).map(&:seats).length
  end

end
