Then /^sub area "(.*?)" should belong to policy area "(.*?)"$/ do |sub_area_name, policy_area_name|
  sub_area = SubArea.find_by_name(sub_area_name)
  sub_area.policy_area.name.should == policy_area_name
end
