require 'spec_helper'

describe Cinema do
  let(:cinema) { FactoryGirl.create :cinema }

  it { should have_many :screens }
  it { should have_many :show_types }
  it { should belong_to :organiser_data }
end
