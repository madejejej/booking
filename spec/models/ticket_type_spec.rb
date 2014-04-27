require 'spec_helper'

describe TicketType do
  let(:ticket_type) { FactoryGirl.create :ticket_type }

  it { should belong_to :show_type }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it { should validate_presence_of :show_type }
end
