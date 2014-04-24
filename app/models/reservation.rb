# TODO: validates booker/user_id presence
class Reservation < ActiveRecord::Base
  belongs_to :show

  has_many :tickets
  has_many :seats, through: :tickets

  validates :show, presence: true
end
