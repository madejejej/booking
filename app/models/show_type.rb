class ShowType < ActiveRecord::Base
  has_many :shows
  has_many :ticket_types
  belongs_to :cinema

  validates :name, presence: true
end
