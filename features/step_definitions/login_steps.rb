def user_password
  "changeme"
end

def user
  @user ||= FactoryGirl.create(:user, password: user_password, password_confirmation: user_password)
end

Given(/^I’m on the login page$/) do
  visit "/#login"
end

Then(/^I should see "(.*?)"$/) do |text|
  page.has_content?(text).should be_true
end

When(/^I provide my credentials$/) do
  within('#login-field') do
    fill_in 'email', with: user.email
    fill_in 'password', with: user_password
  end
end

When(/^I press the login button$/) do
  find_button('Login').click
end


