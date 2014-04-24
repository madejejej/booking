require 'spec_helper'

describe ShowType do
  let(:show_type) { FactoryGirl.create :show_type }

  it { should have_many :shows }
  it { should validate_presence_of :name }
end
