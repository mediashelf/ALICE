Given /^a page "(.*?)" exists with position (\d+)$/ do |title, position|
  FactoryGirl.create(:page, title: title, position: position)
end

Then /^I should see "(.*?)" before "(.*?)"$/ do |first, second|
  within('nav') do
    page.find('ul li:first-child').should have_content(first)
    page.find('ul li:nth(2)').should have_content(second)
  end
end
