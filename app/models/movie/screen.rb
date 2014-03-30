class Movie::Screen < ActiveRecord::Base
  has_many :seats, class_name: Movie::Screen::Seat, inverse_of: :screen
  validates :name, presence: true
end
