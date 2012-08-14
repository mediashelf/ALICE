When /^I search for "(.*?)"$/ do |search_text|
  step %Q(I am on the home page)
  step %Q(I fill in "q" with "#{search_text}")
  step %Q(I press "Search")
end
