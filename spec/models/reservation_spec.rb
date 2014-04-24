require 'spec_helper'

describe Reservation do
  it { should have_many :seats }
  it { should have_many :reservation_seats}
end
