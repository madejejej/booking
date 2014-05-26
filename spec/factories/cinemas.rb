# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cinema do
    name "MyString"
    location "MyString"
    phone "MyString"
    association :organiser_data, factory: :organiser_data
  end
end
