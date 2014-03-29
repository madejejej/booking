require 'spec_helper'

describe Movie do
  let(:movie) { FactoryGirl.create :movie }

  it { should have_many :shows }
end
