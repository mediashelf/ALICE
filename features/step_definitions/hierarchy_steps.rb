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
