Then /^topic "(.*?)" should belong to sub area "(.*?)"$/ do |topic_name, sub_area_name|
  topic = Topic.find_by_name topic_name
  topic.sub_areas.map(&:name).should include(sub_area_name)
end
