require 'spec_helper'

describe Reservation do
  it { should have_many :seats }
end
