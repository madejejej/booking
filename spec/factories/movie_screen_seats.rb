# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_screen_seat, :class => 'Movie::Screen::Seat' do
    association :screen, factory: :movie_screens
  end
end
