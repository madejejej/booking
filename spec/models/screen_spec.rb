require 'spec_helper'

describe Screen do
  let(:screen) { FactoryGirl.create :screen }

  it { should belong_to :cinema }
  it { should have_many :seats }
  it { should validate_presence_of :name }
  it { should have_many :shows}

  describe 'can_play_movie' do

      @screen
      before do
        @screen= Screen.new
        existing_show = FactoryGirl.create :show
        existing_show.date = DateTime.new(2011,10,10,14,0,0)
        existing_show.movie.duration = 119
        @screen.shows << existing_show
      end

      it 'returns true if no other movie is being played at this time' do
        start_date = DateTime.new(2011,10,10,16,0,0)
        end_date = start_date + 120.minutes

        @screen.can_play_movie(start_date,end_date).should be_true
      end

      it 'returns false if existing show would start during new show being played' do
        start_date = DateTime.new(2011,10,10,13,0,0)
        end_date = start_date + 120.minutes

        @screen.can_play_movie(start_date,end_date).should be_false
      end

      it 'returns false if new show would have to be displayed during new show' do
        @screen.shows.first.date = DateTime.new(2011,10,10,13,30,0)
        start_date = DateTime.new(2011,10,10,13,0,0)
        end_date = start_date + 180.minutes

        @screen.can_play_movie(start_date,end_date).should be_false
      end

      it 'returns false if new show would end when existing show would still be played' do
        @screen.shows.first.date = DateTime.new(2011,10,10,12,0,0)
        start_date = DateTime.new(2011,10,10,13,0,0)
        end_date = start_date + 120.minutes

        @screen.can_play_movie(start_date,end_date).should be_false
      end
  end

  describe 'add_show' do
    @screen
    let(:movie_id) { 1 }
    let(:show_type_id) { 1 }
    let(:datetime) { DateTime.new(2011,10,10,13,0,0) }

    before do
      @screen = Screen.new
      existing_show = FactoryGirl.create :show
      existing_show.date = DateTime.new(2011,10,10,14,0,0)
      existing_show.movie.duration = 120
      @screen.shows << existing_show
    end

    it 'should throw exception if no movie found' do
      Movie.should_receive(:find).and_return(nil)

      expect { screen.add_show(movie_id, show_type_id, datetime) }.to raise_error
    end

    it 'should throw exception when no show type found' do
      ShowType.should_receive(:find).and_return(nil)
      Movie.should_receive(:find).and_return(FactoryGirl.build :movie)

      expect { screen.add_show(movie_id, show_type_id, datetime) }.to raise_error
    end

    it 'should throw exception when cannot play movie at that date' do
      ShowType.should_receive(:find).and_return(FactoryGirl.build :show_type)
      Movie.should_receive(:find).and_return(FactoryGirl.build :movie)

      screen.stub(:can_play_movie).with(false)
      expect { screen.add_show(movie_id, show_type_id, datetime) }.to raise_error
    end

    it 'should create new show ' do
      ShowType.should_receive(:find).and_return(FactoryGirl.build :show_type)
      Movie.should_receive(:find).and_return(FactoryGirl.build :movie)

      screen.stub(:can_play_movie).with(true)
      expect { screen.add_show(movie_id, show_type_id, datetime) }.not_to raise_error
    end
  end
end
