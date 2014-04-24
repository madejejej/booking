class Screen < ActiveRecord::Base
  belongs_to :cinema
  has_many :seats
  validates :name, presence: true
end
