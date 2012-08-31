source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'pg'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'therubyracer', '0.11.0beta5'
    gem 'libv8', '~> 3.11.8'
  gem 'uglifier'
  gem 'compass-rails', '~> 1.0.0'
  gem 'compass-susy-plugin', '~> 0.9.0'
end

gem 'activeadmin'
  gem 'meta_search', '>= 1.1.0.pre'

gem 'blacklight'
  gem 'blacklight_range_limit'

gem 'carrierwave'
  gem 'fog', '~> 1.4.0'

gem 'decent_exposure', github: 'voxdolo/decent_exposure', ref: 'fc344d80dfbd0b7295f58c2d1a21c923332e7743'
gem 'devise'
gem 'formtastic', '~> 2.1.1'
gem 'haml'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'sendgrid'
gem 'underscore-rails'

group :development do
  gem 'faker'

  gem 'haml-rails'
    gem 'hpricot'
    gem 'ruby_parser'

  gem 'rb-fsevent'
  gem 'growl'
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
end

group :development, :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'debugger'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'thin'
end

group :production, :staging do
  gem 'unicorn'
end

gem 'rubber'
  gem 'open4'
  gem 'gelf'
  gem 'graylog2_exceptions', :git => 'git://github.com/wr0ngway/graylog2_exceptions.git'
  gem 'graylog2-resque'
