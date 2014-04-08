class Movie::Show < ActiveRecord::Base
  belongs_to :movie, inverse_of: :shows
  belongs_to :screen, class_name: Movie::Screen
  has_many :reservations


  validates :movie, presence: true
  validates :screen, presence: true

  def number_of_free_seats
    occupied_seats = reservations.map(&:seats).length
    all_seats_count - occupied_seats
  end

  def all_seats_count
    screen.seats.count
  end


end
