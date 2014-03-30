class Movie::Screen::Seat < ActiveRecord::Base
  belongs_to :screen, class_name: Movie::Screen, inverse_of: :seats

  validates :screen, presence: true
end
