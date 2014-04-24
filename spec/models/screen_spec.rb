require 'spec_helper'

describe Screen do
  let(:screen) { FactoryGirl.create :screen }

  it { should belong_to :cinema }
  it { should have_many :seats }
  it { should validate_presence_of :name }
end
