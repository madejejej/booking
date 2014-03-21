def user_password
  "changeme"
end

def user
  @user ||= FactoryGirl.create(:user, password: user_password, password_confirmation: user_password)
end

Given(/^I’m on the "(.*?)" page$/) do |page|
  visit "/##{page}"
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

When(/^I press the "(.*?)" button$/) do |button_name|
  find_button(button_name).click
end

When(/^I provide my email and confirm my password$/) do
  within('#register-field') do
    fill_in 'email', with: "user@example.com"
    fill_in 'password', with: "asdasdasd"
    fill_in 'confirm-password', with: "asdasdasd"
  end
end


Then(/^I should have a registered account$/) do
  User.last.email.should eq "user@example.com"
end

Then(/^I should be logged in$/) do
  page.has_content?("Welcome").should be_true
end

