# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_show, :class => 'Movie::Show' do
    association :movie, factory: :movie
    date "2014-03-29 15:22:38"
    association :screen, factory: :movie_screen
  end
end
