class Screen < ActiveRecord::Base
  belongs_to :cinema
  has_many :seats
  validates :name, presence: true

  scope :all_screens_for_cinema_with_seat_count, ->(cinema_id) do
    Screen.where(cinema_id: cinema_id).includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count }}
  end

  scope :screen_with_seat_count, ->(screen_id) do
    Screen.where(id: screen_id).includes(:seats).map { |s| {id: s.id, name: s.name, seats: s.seats.count }}.first
  end

end
