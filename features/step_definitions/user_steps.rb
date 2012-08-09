Given /^I (?:am logged in|log in)$/ do
  step %Q(I log in as "test@example.com")
end

Given /^I am logged out$/ do
  page.should have_content('Login')
end

Given /^I log in as "(.*?)"$/ do |email|
  step %Q(there is a user named "#{email}")
  step %Q(I am on the sign in page)
  step %Q(I fill in "Email" with "#{email}")
  step %Q(I fill in "Password" with "password")
  step %Q(I press the "Sign in" button)
end

Given /^there is a user named "(.*?)"$/ do |username|
  @user = FactoryGirl.create(:user, email: username)
end

Given /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in(field, with: value)
end

Then /^I should be logged in$/ do
  page.should have_content('Log Out')
end

Then /^I should be logged out$/ do
  page.should have_content('Login')
end

Then /^I should not be allowed access the new asset page$/ do
  step %Q(I go to the new asset page)
  step %Q(I should be on the sign in page)
end
