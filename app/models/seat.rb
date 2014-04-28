class Seat < ActiveRecord::Base
  belongs_to :screen

  validates :screen, presence: true

  scope :all_free_for_show, ->(show_id) do
    begin
      show = Show.find(show_id)
      show.screen.seats.select(:id) - show.reservations.map(&:seats).flatten
    rescue Exception
      raise "No show found with id #{show_id}!"
    end

  end

end
