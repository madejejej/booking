require 'spec_helper'

describe Screen do
  let(:screen) { FactoryGirl.create :screen_with_seats }

  it { should belong_to :cinema }
  it { should have_many :seats }
  it { should validate_presence_of :name }

  describe 'screen with seat count' do

    let(:screen) { FactoryGirl.create :screen_with_seats }

    before do
      #Screen.should_receive(:where).with(id: screen.id).and_return(screen)

      #screen.should_receive(:includes).and_return(screen.includes(:seats))
      #Screen.should_receive(:includes).and_call_original
      #Screen.stub_chain(:find, :includes).and_return(screen.include(:seats))
    end

    #it 'should receive screen with seats count' do
    #  result = Screen.screen_with_seat_count(screen.id)
    #  result eq 3
    #end

  end

end
