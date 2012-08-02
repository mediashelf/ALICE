Given /^I am on the (.*?)(?: ?page)$/ do |page_name|
  visit(path_to(page_name))
end

Then /^I should be on the (.*?)(?: ?page)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should match(path_to(page_name))
  begin
    page.status_code.should == 200
  rescue Capybara::NotSupportedByDriverError => e
    # TODO: Find a way to test status codes in Capybara::Driver::Selenium
  end
end

Given /^I press the "(.*?)" button$/ do |button_name|
  click_button(button_name)
end

Given /^I follow "(.*?)"$/ do |link_name|
  click_link(link_name)
end
