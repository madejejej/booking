require 'spec_helper'

describe ShowsController do

  describe "#index" do
    context "with valid movie_id" do
      let(:shows) { FactoryGirl.build_list(:show, 3) }

      before do
        Show.should_receive(:all_for_movie_with_screen).with("1").and_return(shows)
        get :index, movie_id: 1, format: :json
      end

      specify { assigns(:shows).should eq shows }
      specify { response.should be_success }
    end

    context "with invalid movie_id" do
      before do
        Show.should_receive(:all_for_movie_with_screen).with("1").and_return([])
        get :index, movie_id: 1, format: :json
      end

      specify { response.should be_success }
      specify { response.body.should eq "[]" }
    end
  end
end

