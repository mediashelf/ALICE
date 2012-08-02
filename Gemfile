source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'pg'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

gem 'blacklight'
gem 'decent_exposure', github: 'voxdolo/decent_exposure', ref: 'fc344d80dfbd0b7295f58c2d1a21c923332e7743'
gem 'devise'
gem 'draper'
gem 'formtastic'
gem 'haml'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'sendgrid'
gem 'underscore-rails'

group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'guard-rspec'

  gem 'haml-rails'
    gem 'hpricot'
    gem 'ruby_parser'
  gem 'heroku'
  gem 'heroku_san'

  gem 'rb-fsevent'
  gem 'growl'
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
end

group :development, :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'thin'
end

group :production, :staging do
  gem 'unicorn'
end

gem "compass-rails", "~> 1.0.0", :group => :assets
gem "compass-susy-plugin", "~> 0.9.0", :group => :assets
