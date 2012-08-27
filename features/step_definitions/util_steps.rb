Given /^I debug$/ do
  require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger
  true
end

Given /^I pry$/ do
  binding.pry
  true
end

When /^show me the page$/ do
  save_and_open_page
end
