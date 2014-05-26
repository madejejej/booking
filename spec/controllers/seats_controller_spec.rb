require 'spec_helper'

describe SeatsController do

    context "for logged in user" do
      let!(:cinema) { FactoryGirl.create :cinema }
      let!(:screen) { FactoryGirl.create :screen, cinema_id: cinema.id }
      let!(:user) { setup_organiser_sign_in }
      let!(:seats) { '[ {"x": 1, "y": 1}, {"x": 1, "y": 2} ]' }
      before do
        post :create, cinema_id: cinema.id, screen_id: screen.id, seats: seats, format: :json
      end

      it "should create the seats" do
        response.should be_success
      end
    end

end