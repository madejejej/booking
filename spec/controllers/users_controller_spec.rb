require 'spec_helper'

describe UsersController do
  describe '#whoami' do

    context "for authenticated user" do
      let!(:user) { FactoryGirl.create :user }

      before do
        sign_in user
        get :whoami, format: :json
      end

      specify { expect(response).to be_success }
      specify { expect(json_response["id"]).to eq user.id }
      specify { expect(json_response["email"]).to eq user.email }
    end

    context "for not authenticated user" do
      before { get :whoami, format: :json }

      specify { expect(response).to be_not_found }
    end
  end
end
