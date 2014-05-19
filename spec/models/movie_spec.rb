require 'spec_helper'

describe Movie do
  let(:movie) { FactoryGirl.create :movie }

  it { should have_many :shows }
  it { should have_many(:cinemas).through :shows}

  it { should validate_presence_of :title}
  it { should validate_presence_of :description}

end
