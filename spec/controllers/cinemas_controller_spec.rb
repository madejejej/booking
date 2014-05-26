require 'spec_helper'

shared_examples "not authorized user" do |verb, action, params={}|
  context "for not logged in user" do
    before { send(verb, action, params.merge({format: :json})) }

    it "redirects to rootpath" do
      response.should redirect_to root_path
    end

  end

  context "for the logged in user who is not an organizer" do
    let!(:user) { FactoryGirl.create :user }
    before do
      sign_in user
      send(verb, action, params.merge({format: :json}))
    end

    it "redirects to rootpath" do
      response.should redirect_to root_path
    end

  end
end

describe CinemasController do
  describe "#index" do

    include_examples "not authorized user", :get, :index

    context "for the logged in organiser" do
      let!(:user) { setup_organiser_sign_in }
      let!(:cinemas) { FactoryGirl.create_list(:cinema, 3) }
      before do
        get :index, format: :json
      end

      it "ends with success" do
        response.should be_success
      end
    end
  end

  describe "#show" do
    let!(:cinema) { FactoryGirl.create :cinema }
    before do
      get :show, id: cinema.id, format: :json
    end

    it "retrieves cinema inf" do
      assigns(:cinema).should eq cinema
    end

    it "ends with success" do
      response.should be_success
    end

  end

  describe "#create" do
    include_examples "not authorized user", :post, :create, cinema: { name: "name", location: "location", phone: "phone" }

    context "for logged in user" do
      let!(:cinema_params) { { name: "name", location: "location", phone: "phone" } }
      let!(:user) { setup_organiser_sign_in }

      before do
        post :create, cinema: cinema_params, format: :json
      end

      it "should create the cinema" do
        assigns(:cinema).should be_persisted
      end
    end

  end

  describe "#destroy" do
    include_examples "not authorized user", :delete, :destroy, id: 1
  end

end
