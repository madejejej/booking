class ShowType < ActiveRecord::Base
  has_many :shows
  belongs_to :cinema

  validates :name, presence: true
end
