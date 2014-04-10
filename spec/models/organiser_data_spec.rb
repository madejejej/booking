require 'spec_helper'

describe OrganiserData do
  let(:organiser_data) { FactoryGirl.create :organiser_datum }

  it { should have_many :users }
end
