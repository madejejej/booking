require 'spec_helper'

describe Ticket do
  it { should belong_to :reservation }
  it { should belong_to :seat }
  it { should belong_to :ticket_type }

  it { should validate_presence_of :reservation }
  it { should validate_presence_of :seat }
end
