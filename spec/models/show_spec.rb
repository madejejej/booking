require 'spec_helper'

describe Show do
  let(:show) { FactoryGirl.create :show }

  it { should belong_to :show_type }
  it { should belong_to :movie }
  it { should belong_to :screen }

  it { should validate_presence_of :movie }
  it { should validate_presence_of :screen }
  it { should validate_presence_of :show_type }

  it { should have_many :reservations }
  it { should have_many(:cinemas).through :screen }

  describe '#number_of_free_seats' do

    let(:r1) { double("Reservation") }

    before do
      @seats_ids = show.screen.seats.ids
      show.reservations << FactoryGirl.create(:ticket, :seat => Seat.new(id: @seats_ids[0])).reservation
    end

    it { r1.should_not be_nil }

    it 'should return all seats count from associated screen' do
      seats_count = 10
      show.screen.seats.stub count: seats_count
      show.all_seats_count.should eq seats_count
    end

    it 'should return number of available seats to book' do
      #show.number_of_free_seats.should eq show.screen.seats.count - show.reservations.map(&:tickets).flatten.count
      show.number_of_free_seats.should eq 2
    end

    it 'return available seats ids' do
      show.available_seats_ids.should eq (@seats_ids - [@seats_ids[0]])
    end

  end
end

