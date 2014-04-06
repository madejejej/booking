require 'spec_helper'

describe Movie::Show do
  let(:show) { FactoryGirl.create :movie_show }

  it { should belong_to :movie }
  it { should belong_to :screen }

  it { should validate_presence_of :movie }
  it { should validate_presence_of :screen }

  it { should have_many :reservations }

  describe '#number_of_free_seats' do
    before do
    end

  end
end

