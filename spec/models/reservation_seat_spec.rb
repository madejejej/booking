require 'spec_helper'

describe ReservationSeat do
  it { should belong_to :reservation }
  it { should belong_to :seat }

  it { should validate_presence_of :reservation }
  it { should validate_presence_of :seat }
end
