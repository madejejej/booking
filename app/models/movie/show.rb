class Movie::Show < ActiveRecord::Base
  belongs_to :movie, inverse_of: :shows
  belongs_to :screen, class_name: Movie::Screen

  validates :movie, presence: true
  validates :screen, presence: true
end
