require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'cucumber'

  if RUBY_VERSION > "1.9"
    require 'simplecov'
    SimpleCov.start 'rails' if ENV["COVERAGE"]
    SimpleCov.coverage_dir 'coverage/cucumber'
  end

  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  require File.dirname(__FILE__) + "/../../config/environment.rb"

  require 'cucumber/rails'
  require 'cucumber/rails/world'

  Before('@javascript', '@selenium', '@no-txn') do
    DatabaseCleaner.strategy = :truncation
  end

  After('@javascript', '@selenium', '@no-txn') do
    DatabaseCleaner.clean_with :truncation
  end

  Before('~@javascript', '~@selenium', '~@no-txn')do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  After('~@javascript', '~@selenium', '~@no-txn')do
    DatabaseCleaner.clean
  end

  ActiveRecord::Base.connection.disconnect!
end

Spork.each_run do
  ActiveRecord::Base.establish_connection
  require 'machinist/active_record'
  Dir[Rails.root.join("app/models/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/support/blueprints/**/*.rb")].each { |f| require f }
  I18n.backend.reload!
  DatabaseCleaner.clean_with :truncation
end
