# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket_type do
    type "Normal"
    price_in_eurocents 1000
    association :show_type
  end
end
