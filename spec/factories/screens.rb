# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :screen, :class => 'Screen' do
    name "Movie Screen"
  end

  factory :screen_with_seats, parent: :screen do |screen|
    screen.seats { build_list :seat, 3 }
  end
end
