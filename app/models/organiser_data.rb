class OrganiserData < ActiveRecord::Base
  validates_with NIPValidator

  has_many :users
end
