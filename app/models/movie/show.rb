class Movie::Show < ActiveRecord::Base
  belongs_to :movie, inverse_of: :shows
  belongs_to :screen, class_name: Movie::Screen

  validates :movie, presence: true
  validates :screen, presence: true

  scope :all_for_movie_with_screen, ->(movie_id) do
    select(:date, :name).where(movie_id: movie_id).joins(:screen)
  end

end
