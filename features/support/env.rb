require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

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

  DatabaseCleaner.strategy = :transaction

  Before '@javascript', '@selenium', '@no-txn' do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with :truncation
  end

  Before '~@javascript', '~@selenium', '~@no-txn' do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  After '~@javascript', '~@selenium', '~@no-txn' do
    DatabaseCleaner.clean
  end

  ActiveRecord::Base.connection.disconnect!
end

Spork.each_run do
  ActiveRecord::Base.establish_connection
  Dir[Rails.root.join("app/models/**/*.rb")].each { |f| load f }
  Dir[Rails.root.join("spec/blueprints/**/*.rb")].each { |f| require f }
  I18n.backend.reload!
end
