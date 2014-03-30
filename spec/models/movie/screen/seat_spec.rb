require 'spec_helper'

describe Movie::Screen::Seat do
  let(:seat) { FactoryGirl.create :movie_screen_seat }

  it { should belong_to :screen }
  it { should validate_presence_of :screen }
end
