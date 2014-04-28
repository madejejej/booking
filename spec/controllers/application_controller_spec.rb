require 'spec_helper'

describe ApplicationController do
  controller do
    before_action :require_organiser_authentication!
    def index
      head :ok
    end
  end

  describe "#require_organiser_authentication!" do

    context "user not authenticated" do
      it "redirects" do
        get :index
        response.should be_redirect
      end
    end

    context "user authenticated but not an organiser" do
      let(:user) { FactoryGirl.create :user }

      it "redirects" do
        sign_in user
        get :index
        response.should be_redirect
      end
    end

    context "user authenticated as an organiser" do
      let(:organiser_data) { FactoryGirl.create :organiser_data }
      let(:user) { FactoryGirl.create :user, organiser_data: organiser_data }

      it "successfuly authenticates" do
        sign_in user
        get :index
        response.should be_success
      end
    end
  end
end
