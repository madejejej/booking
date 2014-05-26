class Screen < ActiveRecord::Base
  belongs_to :cinema
  has_many :seats
  has_many :shows

  validates :name, presence: true

  scope :all_screens_for_cinema_with_seat_count, ->(cinema_id) do
    Screen.where(cinema_id: cinema_id).includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count }}
  end

  scope :screen_with_seat_count, ->(screen_id) do
    Screen.where(id: screen_id).includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count} }.first
  end

  def can_play_movie (start_date, end_date)
    shows.select { |show| not( show.end_date < start_date or show.date > end_date)}.empty?
  end

  def add_show(movie_id, show_type_id, datetime)

    movie = Movie.find(movie_id)
    raise 'No such movie exists!' if movie.nil?
    show_type = ShowType.find(show_type_id)
    raise 'No such show type exists!' if show_type.nil?

    raise 'During that time screen is displaying another show already!' unless can_play_movie(datetime, datetime+movie.duration.minutes)

    shows << Show.new(movie: movie,show_type: show_type, date: datetime )

  end


end
