Given /^I (?:am on|go to) the (.*?)(?: ?page)$/ do |page_name|
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

Given /^I press "([^"]*?)"$/ do |button_name|
  click_button(button_name)
end

Given /^I follow "([^"]*?)"$/ do |link_name|
  click_link(link_name)
end

Given /^I follow "([^"]*?)" within "([^"]*?)"$/ do |link_name, wrapper_element|
  within(wrapper_element) do
    click_link(link_name)
  end
end

Then /^I should see "([^"]*?)"$/ do |expected_text|
  page.should have_content(expected_text)
end

Then /^I should see "([^"]*?)" within "([^"]*?)"$/ do |expected_text, wrapper_element|
  within(wrapper_element) do
    page.should have_content(expected_text)
  end
end

Then /^I should not see "([^"]*?)"$/ do |undesired_text|
  page.should_not have_content(undesired_text)
end

Then /^I should not see the "([^"]*?)" element within "([^"]*?)"$/ do |selector, wrapper_element|
  within(wrapper_element) do
    page.should_not have_selector(selector)
  end
end

Then /^I should not see "([^"]*?)" within "([^"]*?)"$/ do |text, wrapper_element|
  within(wrapper_element) do
    page.should_not have_content(text)
  end
end

When /^I fill in the following:$/ do |field_table|
  field_table.hashes.each do |hash|
    field_name = hash['Field']
    value = hash['Value']
    step %Q(I fill in "#{field_name}" with "#{value}")
  end
end

When /^I select "([^"]*?)" from "([^"]*?)"$/ do |value, select_label|
  select(value, from: select_label)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |file_name, field|
  attach_file(field, File.expand_path(File.join(Rails.root, "support", file_name)))
end
