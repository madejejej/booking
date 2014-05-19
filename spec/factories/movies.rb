# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "MyString"
    description "MyText"
    cover_url "MyString"
    duration 120
  end
end
