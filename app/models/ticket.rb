class Ticket < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :seat
  belongs_to :ticket_type

  validates :reservation, presence: true
  validates :seat, presence: true
end
