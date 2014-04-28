class Movie < ActiveRecord::Base
  has_many :shows
  validates :title, presence: true
  validates :description, presence: true
end
