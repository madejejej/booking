Given(/^I’m on the login page$/) do
  visit "/#login"
end

Then(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  within('#login-field') do
    fill_in field, with: value
  end
end

When(/^I press "(.*?)"$/) do |button_name|
  find_button(button_name).click
end

Then(/^I should see "(.*?)"$/) do |text|
  page.has_content?(text).should be_true
end
