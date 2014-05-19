class Screen < ActiveRecord::Base
  belongs_to :cinema
  has_many :seats
  has_many :shows

  validates :name, presence: true

  scope :all_screens_for_cinema_with_seat_count, ->(cinema_id) do
    Screen.all.includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count} }
  end

  scope :screen_with_seat_count, ->(screen_id) do
    Screen.where(id: screen_id).includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count} }.first
  end

  def can_play_movie (start_date, end_date)
    shows.select { |show| not( show.end_date < start_date or show.date > end_date)}.empty?
  end


end
