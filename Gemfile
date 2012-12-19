source 'https://rubygems.org'

gem 'rails'

gem 'inherited_resources'
gem 'activeadmin'
gem 'meta_search'

gem 'delayed_job_active_record'
gem 'delayed_job_admin'

gem 'redis'
gem 'resque', :require => 'resque/server'

gem 'devise',           '>= 2.0.0'
gem 'devise_invitable', '~> 1.0.0'

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

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
  gem 'bootstrap-sass', '~> 2.2.1.1'
  gem 'sassy-buttons'
end

group :development, :test do
  gem 'mysql2'
  gem 'rspec-rails'
  gem 'capybara'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'capybara-webkit', :git => 'https://github.com/thoughtbot/capybara-webkit.git'
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
    gem 'ruby_gntp'
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
