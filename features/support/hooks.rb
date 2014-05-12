require 'capybara/poltergeist'

Before('@javascript') do
    Capybara.current_driver = :poltergeist
end
