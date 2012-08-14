Given /^an asset with topic "(.*?)" and summary "(.*?)"$/ do |topic, summary|
  Asset.create! topic: topic, summary: summary
end
