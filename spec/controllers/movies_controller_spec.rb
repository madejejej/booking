require 'spec_helper'

describe MoviesController do
  describe "#index" do
    let(:movies) { FactoryGirl.build_list(:movie, 3) }

    before do
      Movie.should_receive(:all).and_return(movies)
      get :index, format: :json
    end

    it "retrieves all movies" do
      assigns(:movies).should eq movies
    end

    it "responds with success" do
      response.should be_success
    end
  end
end
