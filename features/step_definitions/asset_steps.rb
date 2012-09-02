Given /^an asset with title "([^"]*?)" and summary "([^"]*?)"$/ do |title, summary|
  FactoryGirl.create :asset, title: title, summary: summary
end
