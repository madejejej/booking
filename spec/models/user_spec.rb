require 'spec_helper'

describe User do
  it "has valid factory" do
    FactoryGirl.create(:user)
  end

  it { should belong_to :organiser_data }
end
