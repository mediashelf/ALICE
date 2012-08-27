Given /^an asset with topic "([^"]*?)" and summary "([^"]*?)"$/ do |topic, summary|
  FactoryGirl.create :asset, topic: topic, summary: summary
end
