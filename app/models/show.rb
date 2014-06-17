class Show < ActiveRecord::Base
  belongs_to :movie
  belongs_to :screen
  belongs_to :show_type

  has_many :reservations
  has_many :cinemas, through: :screen

  validates :movie, presence: true
  validates :screen, presence: true
  validates :show_type, presence: true

  scope :all_for_movie_with_screen, ->(movie_id) do
    select(:date, :name, 'shows.id').where(movie_id: movie_id).joins(:screen)
  end

  scope :all_for_screen, ->(screen_id) do
    select(:date, :title).where(screen_id: screen_id).joins(:movie)
  end

  def available_seats_ids
    screen.seats.ids - reservations.map(&:seats).flatten.map(&:id)
  end

  def number_of_free_seats
    occupied_seats = reservations.map(&:seats).flatten.length
    all_seats_count() - occupied_seats
  end

  def all_seats_count
    screen.seats.count
  end

  def end_date
    date+movie.duration.minutes
  end

end
