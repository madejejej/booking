class Screen < ActiveRecord::Base
  belongs_to :cinema
  has_many :seats
  validates :name, presence: true

  scope :all_screens_for_cinema_with_seat_count, ->(cinema_id) do
    Cinema.find(cinema_id).screens.includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count }}
  end

  scope :screen_with_seat_count, ->(screen_id) do

    Screen.find(screen_id).includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count }}.first
  end

end
