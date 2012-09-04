Given /^a page "(.*?)" exists$/ do |title|
  create(:page, title: title)
end

Given /^a page "([^"]+)" exists with position (\d)$/ do |title, position|
  create(:page, title: title, position: position)
end

Given /^a page "(.*?)" exists with body "([^"]+)"$/ do |title, content|
  create(:page, title: title, body: content)
end

Given /^a child page "(.*?)" exists with parent "([^"]+)" and position (\d+)$/ do |title, parent_title, position|
  parent = Page.where(title: parent_title).first
  create(:page, title: title, parent: parent, position: position)
end

Then /^I should see "(.*?)" before "(.*?)" in the main navigation$/ do |first, second|
  within('nav') do
    page.find('ul li:first-child').should have_content(first)
    page.find('ul li:nth(2)').should have_content(second)
  end
end

Then /^I should see "(.*?)" before "(.*?)" in the page subnavigation$/ do |first, second|
  within('.main') do
    page.find('ul li:first-child').should have_content(first)
    page.find('ul li:nth(2)').should have_content(second)
  end
end
