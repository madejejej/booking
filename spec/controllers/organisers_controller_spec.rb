require 'spec_helper'

describe OrganisersController do
  let(:user) { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }
  let(:valid_nip) { "1234563218" }
  let(:name) { "MultiCinema" }

  describe "#create" do
    context "authenticated" do
      let(:user_id) { user.id }
      let(:nip) { valid_nip }

      before do
        sign_in user
        post :create, format: :json, user_id: user_id, organiser_data: {nip: nip, name: name, description: "Our cinema is the best cinema!"}
      end

      context "with valid params" do
        it "responds with success" do
          response.should be_success
        end

        it "persists the data" do
          assigns(:organiser_data).should be_persisted
        end
      end

      context "with invalid params" do
        let(:nip) { "123" }

        specify { response.response_code.should eq 422 }
        specify { JSON.parse(response.body)["errors"].should be_present }
      end

      context "with not my user id" do
        let(:user_id) { other_user.id }

        specify { response.response_code.should eq 400 }
      end
    end

    context "unauthenticated" do
      before { post :create, format: :json, user_id: user.id, organiser_data: {nip: valid_nip, name: name} }
      specify { response.response_code.should eq 401 }
    end
  end
end
