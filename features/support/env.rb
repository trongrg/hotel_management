require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require 'cucumber/rails'
  require 'capybara/rails'
  require 'capybara/cucumber'
  require 'capybara/session'

  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  begin
    DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

  Before('@no-txn,@selenium,@javascript') do
    DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
  end

  Before('~@no-txn', '~@selenium', '~@javascript') do
    DatabaseCleaner.strategy = :transaction
  end

  Capybara.default_selector = :css
end

Spork.each_run do
  Dir[Rails.root.join("app/models/**/*.rb")].each { |f| load f }
  Dir["#{Rails.root}/spec/support/blueprints/**/*.rb"].each { |f| require f }
  require "#{Rails.root}/spec/support/reload_lib"
  require "#{Rails.root}/spec/support/i18n"
  #require 'pickle'
  DatabaseCleaner.clean_with(:truncation)
end

