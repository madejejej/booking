class Movie < ActiveRecord::Base
  has_many :shows
  has_many :cinemas, through: :shows, uniq: true

  validates :title, presence: true
  validates :description, presence: true

end
