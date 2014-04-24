class Screen < ActiveRecord::Base
  has_many :seats
  validates :name, presence: true
end
