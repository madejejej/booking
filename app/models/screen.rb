class Screen < ActiveRecord::Base
  belongs_to :cinema
  has_many :seats
  validates :name, presence: true

  scope :all_screens_for_cinema_with_seat_count, ->(cinema_id) do
    Screen.all.includes(:seats).map { |s| {name: s.name, seats: s.seats.count }}
  end

end
