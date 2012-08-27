Then /^Verify hierarchy presence as follows:$/ do |assertion_table|
  assertion_table.hashes.each do |hash|
    page_name = hash['page']
    present = hash['present']

    step %Q(I am on the #{page_name} page)
    if present == 'yes'
      unless page.has_content?("Create new Policy Area")
        fail "Missing hierarchy on #{page_name} page"
      end
    else
      if page.has_content?("Create new Policy Area")
        fail "Hierarchy forbidden on #{page_name} page"
      end
    end
  end
end

Given /^an? "([^"]*?)" policy area$/ do |name|
  FactoryGirl.create :policy_area, name: name
end

Given /^an "(.*?)" sub area within "(.*?)"$/ do |sub_area_name, policy_area_name|
  policy_area = FactoryGirl.create :policy_area, name: policy_area_name
  FactoryGirl.create :sub_area, name: sub_area_name, policy_area: policy_area
end

Then /^"(.*?)" should appear in the hierarchy$/ do |target_text|
  within('#hierarchy') do
    page.should have_xpath("//li[@class='policy_area show_sub_areas']//h4[text()='#{target_text}']")
  end
end

Then /^"(.*?)" should not appear in the hierarchy$/ do |target_text|
  within('#hierarchy') do
    page.should have_xpath("//li[@class='policy_area hide_sub_areas']//h4[text()='#{target_text}']")
  end
end

When /^I click on policy area "(.*?)"$/ do |target|
  page.find('h3', text: target).click
end
