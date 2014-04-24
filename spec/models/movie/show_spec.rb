require 'spec_helper'

describe Movie::Show do
  let(:show) { FactoryGirl.create :movie_show }

  it { should belong_to :movie }
  it { should belong_to :screen }

  it { should validate_presence_of :movie }
  it { should validate_presence_of :screen }

  it { should have_many :reservations }

  describe '#number_of_free_seats' do

    let(:r1) { double("Reservation") }

    before do
      show.reservations << FactoryGirl.create(:reservation_seat).reservation
    end

    it { r1.should_not be_nil }

    it "should return all seats count from associated screen" do
      show.screen.seats.stub count: 10
      show.all_seats_count.should eq 10
    end

    it "should return number of available seats to book" do
      show.number_of_free_seats.should eq 2
    end

  end
end

