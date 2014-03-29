require 'spec_helper'

describe Movie::Screen do
  let(:screen) { FactoryGirl.create :movie_screen }

  it { should have_many :seats }
  it { should validate_presence_of :name }
end
