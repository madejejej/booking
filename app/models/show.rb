class Show < ActiveRecord::Base
  belongs_to :movie
  belongs_to :screen
  belongs_to :show_type

  has_many :reservations

  validates :movie, presence: true
  validates :screen, presence: true
  validates :show_type, presence: true

  scope :all_for_movie_with_screen, ->(movie_id) do
    select(:date, :name, 'shows.id').where(movie_id: movie_id).joins(:screen)
  end


  def number_of_free_seats
    occupied_seats = reservations.map(&:seats).length
    all_seats_count - occupied_seats
  end

  def all_seats_count
    screen.seats.count
  end


end
