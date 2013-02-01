source 'https://rubygems.org'

gem 'rails'

gem 'inherited_resources'
gem 'activeadmin'
gem 'meta_search'

gem 'delayed_job_active_record'
gem 'delayed_job_admin'

gem 'redis'
gem 'resque', :require => 'resque/server'

gem 'devise'
gem 'devise_invitable'

gem 'formtastic'
gem 'country_select'
gem 'nested_form'

gem 'kaminari'

gem 'coffee-filter'
gem 'jquery-rails'
gem 'client_side_validations'
gem 'client_side_validations-formtastic'

gem 'carmen'
gem 'cancan'
gem 'role_model'

gem 'money-rails'
gem 'google_currency', :git => 'git://github.com/RubyMoney/google_currency.git'

gem 'settingslogic'

gem 'geocoder'

gem 'friendly_id'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'bootstrap-sass'
  gem 'sassy-buttons'
end

group :development, :test do
  gem 'mysql2'
  gem 'rspec-rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'machinist'
  gem 'faker'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'awesome_print'
  gem 'haml-rails'
  gem 'spork', :git => 'git://github.com/sporkrb/spork.git'
  gem 'guard-livereload'
  gem 'yajl-ruby'
  gem 'rack-livereload'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-redis'
  gem 'guard-resque'
  gem 'guard-rspec'
  require 'rbconfig'
  HOST_OS = RbConfig::CONFIG['host_os']
  case HOST_OS
  when /darwin/i
    gem 'rb-fsevent'
    gem 'terminal-notifier-guard'
  when /linux/i
    gem 'libnotify'
    gem 'rb-inotify'
  when /mswin|windows/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu'
  end
end

group :production do
  gem 'pg'
end
