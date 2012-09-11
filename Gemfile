source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'pg'

group :assets do
  gem 'coffee-rails'
  gem 'therubyracer', '0.11.0beta5'
    gem 'libv8', '~> 3.11.8'
  gem 'uglifier'
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'susy'
  gem 'fancy-buttons'
  gem 'chosen-rails'
end
gem 'tinymce-rails', github: 'spohlenz/tinymce-rails'

gem 'activeadmin'
  gem 'meta_search', '>= 1.1.0.pre'

gem 'blacklight'
  gem 'blacklight_range_limit'
  gem 'blacklight_facet_extras', github: 'mediashelf/blacklight_facet_extras', ref: '0c72bfe597dac34efba22892ffba288bef4ec450'

gem 'carrierwave'
  gem 'fog', '~> 1.4.0'

gem 'acts_as_list'
gem 'decent_exposure', github: 'voxdolo/decent_exposure', ref: 'fc344d80dfbd0b7295f58c2d1a21c923332e7743'
gem 'devise'
gem 'formtastic', '~> 2.1.1'
gem 'haml'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'sendgrid'
gem 'underscore-rails'

group :development do
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
end

group :development, :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'debugger'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'thin'
end

group :development, :test, :staging do
  gem 'factory_girl_rails'
  gem 'faker'
end

group :production, :staging do
  gem 'unicorn'
end

gem 'rubber'
  gem 'open4'
  gem 'gelf'
  gem 'graylog2_exceptions', :git => 'git://github.com/wr0ngway/graylog2_exceptions.git'
  gem 'graylog2-resque'
