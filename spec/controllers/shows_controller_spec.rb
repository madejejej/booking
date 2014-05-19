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

  describe '#create' do
    context 'with no existing screen' do
      before do
        Screen.should_receive(:find).and_return(nil)
        post :create, {screen_id: 1, movie_id: 1, datetime: DateTime.now, show_type_id: 1}, format: :json

      end
      specify { response.status.should eq 422 }
    end

    context 'with no existing show type' do
      before do
        Screen.should_receive(:find).and_return(FactoryGirl.build :screen)
        ShowType.should_receive(:find).and_return(nil)
        post :create, {screen_id: 1, movie_id: 1, datetime: DateTime.now, show_type_id: 1}, format: :json
      end

      specify { response.status.should eq 422}
    end
  end
end

