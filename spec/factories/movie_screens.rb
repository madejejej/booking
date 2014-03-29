# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_screen, :class => 'Movie::Screen' do
    name "Movie Screen"
  end
end
