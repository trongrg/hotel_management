source 'http://rubygems.org'

gem 'rails', '3.2.2'

gem "devise"
gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "settingslogic"
gem "coffee-filter"
gem "formtastic"
gem "carmen"
gem "cancan"
gem "kaminari"
gem 'client_side_validations'
gem 'money'
gem "google_currency", :git => 'git://github.com/RubyMoney/google_currency.git'
gem 'devise_invitable'

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem "compass", ">= 0.12.rc"
  gem "sassy-buttons"
end

gem 'jquery-rails'

group :development, :test do
  gem 'mysql2'
  gem 'debugger'
end

group :test do
  gem "rspec-rails"
  gem "cucumber-rails", :require => false
  gem "capybara"
  gem 'capybara-webkit'
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'machinist'
  gem 'faker'
  gem 'shoulda'
  gem 'spork', :git => "git://github.com/sporkrb/spork.git"
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'timecop'
  #gem 'webmock'
end
