class Cinema < ActiveRecord::Base
  has_many :screens
  has_many :show_types
  belongs_to :organiser_data

end
