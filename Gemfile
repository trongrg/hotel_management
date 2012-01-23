source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem "devise"
gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "settingslogic"
gem "coffee-filter"
gem "formtastic"
gem "carmen"
gem "cancan"
gem "kaminari"
group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem "compass", '>= 0.12.alpha'
  gem "sassy-buttons"
end

gem 'jquery-rails'

group :development, :test do
  gem 'mysql2'
  gem 'ruby-debug-base19', '~> 0.11.26'
  gem 'linecache19', '~> 0.5.13'
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem "rspec-rails", ">= 2.0.1"
  gem "cucumber-rails"
  gem "capybara"
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'machinist'
  gem 'faker'
  gem 'shoulda', '>= 3.0.0.beta'
  gem 'spork', :git => "git://github.com/sporkrb/spork.git"
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  #gem 'webmock'
end
