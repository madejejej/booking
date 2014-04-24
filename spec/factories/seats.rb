# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :seat, :class => 'Seat' do
    association :screen, factory: :screen
  end
end
