# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organiser_data, :class => 'OrganiserData' do
    name "MyCompany"
    description "In MyCompany we believe in super duper movies"
    nip "1234563218"
  end
end
