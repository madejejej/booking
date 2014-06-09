# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "MyString"
    description "MyText"
    duration 120
    cover "cover.jpg"
  end
end
