require 'spec_helper'

describe Seat do
  let(:seat) { FactoryGirl.create :seat }

  it { should belong_to :screen }
  it { should validate_presence_of :screen }

  describe 'all free for show' do
    let(:show) {FactoryGirl.create :show}

    context 'show not being found' do
      it 'should raise exception when no show found' do
        Show.should_receive(:find).and_raise()
        expect {Seat.all_free_for_show(show.id)}.to raise_error
      end
    end

    context 'show being found successfully' do

      before do
        Show.should_receive(:find).and_return(show)
      end

      it 'should return all seats if no reservation was made' do
        result = Seat.all_free_for_show(show.id)
        result.count.should eq show.screen.seats.count
      end

      it 'should return free seats' do
        reservation = FactoryGirl.create(:reservation, show: show)
        reservation.tickets << Ticket.new(seat: show.screen.seats[0])

        show.reservations << reservation
        result = Seat.all_free_for_show(show.id)
        result.count.should eq show.screen.seats.count - reservation.tickets.count
      end
    end
  end
end
