# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_screen, :class => 'Movie::Screen' do
    name "Movie Screen"
    #after(:create) { |screen| screen.seats = FactoryGirl.create_list(:movie_screen_seat, 3)}
  end

  factory :screen_with_seats, parent: :movie_screen do |screen|
    screen.seats { build_list :movie_screen_seat, 3 }
  end
end