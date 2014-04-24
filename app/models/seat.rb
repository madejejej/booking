class Seat < ActiveRecord::Base
  belongs_to :screen

  validates :screen, presence: true
end
