Given /^an? "(.*) - (.*) - (.*)" hierarchy exists$/ do |policy_area_name, sub_area_name, topic_name|
  step %Q(a "#{sub_area_name}" sub area within "#{policy_area_name}")
  step %Q(a "#{topic_name}" topic within sub area "#{sub_area_name}")
end

Given /^an? "([^"]*?)" policy area$/ do |name|
  FactoryGirl.create :policy_area, name: name
end

Given /^an? "(.*?)" sub area within "(.*?)"$/ do |sub_area_name, policy_area_name|
  policy_area = FactoryGirl.create :policy_area, name: policy_area_name
  FactoryGirl.create :sub_area, name: sub_area_name, policy_area: policy_area
end

Given /^an? "(.*?)" topic within sub area "(.*?)"$/ do |topic_name, sub_area_name|
  sub_area = SubArea.find_by_name sub_area_name
  topic = FactoryGirl.create :topic, name: topic_name
  topic.sub_areas << sub_area
end

Given /^an? "([^"]*?)" sub area within a policy area$/ do |name|
  FactoryGirl.create :sub_area, :with_policy_area, name: name
end

Given /^an? "([^"]*?)" sub area$/ do |name|
  FactoryGirl.create :sub_area, name: name
end
