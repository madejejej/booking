class Ticket < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :seat

  validates :reservation, presence: true
  validates :seat, presence: true
end
