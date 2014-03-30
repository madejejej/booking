class Movie < ActiveRecord::Base
  has_many :shows, class_name: Movie::Show
end
