class Seat < ActiveRecord::Base
  belongs_to :screen

  validates :screen, presence: true

  scope :all_free_for_show, ->(show_id) do
    show = Show.find(show_id)
    show.screen.seats.select(:id) - show.reservations.map(&:seats).flatten
  end

end
