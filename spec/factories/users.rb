# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'changeme'
    password_confirmation 'changeme'
  end
end
