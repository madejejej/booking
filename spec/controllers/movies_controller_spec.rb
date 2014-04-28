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

  describe "#create" do
    let(:movie_params) { {title: "Matrix", description: "Super Neo!", duration: "120", director: "Myself" } }

    describe "Happy path" do
      before do
        setup_organiser_sign_in
        post :create, movie: movie_params, format: :json
      end

      specify { response.should be_success }
      specify { assigns(:movie).should be_persisted }
    end

    describe "wrong params" do
      let(:wrong_movie_params) { { description: "LOL NO TITLE" } }
      before do
        setup_organiser_sign_in
        post :create, movie: wrong_movie_params, format: :json
      end

      specify { response.should be_unprocessable }
      specify { json_response["errors"].should be_present }
    end

    describe "not authenticated" do
      it "redirects" do
        post :create, movie: movie_params, format: :json
        response.should be_redirect
        assigns(:movie).should be_nil
      end
    end
  end
end
