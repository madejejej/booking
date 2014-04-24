require 'spec_helper'

describe Reservation do
  it { should belong_to :show }
  it { should have_many :seats }
  it { should have_many :tickets}

  it { should validate_presence_of :show }
end
