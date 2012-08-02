Given /^I log in as "(.*?)"$/ do |email|
  step "there is a user named \"#{email}\""
  step "I am on the sign in page"
  step "I fill in \"Email\" with \"#{email}\""
  step "I fill in \"Password\" with \"password\""
  step "I press the \"Sign in\" button"
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
