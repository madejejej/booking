require 'spec_helper'

describe Seat do
  let(:seat) { FactoryGirl.create :seat }

  it { should belong_to :screen }
  it { should validate_presence_of :screen }
end
