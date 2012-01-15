require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require 'simplecov'
  require 'rails/application'
  require 'cucumber/rails'
  require 'cucumber/rspec/doubles'

  #Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

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
  #Dir["#{Rails.root}/app/models/*.rb"].each { |f| load f }
  require 'capybara'
  Dir["#{Rails.root}/spec/support/blueprints/**/*.rb"].each { |f| require f }
  require "#{Rails.root}/spec/support/reload_lib"
  require "#{Rails.root}/spec/support/i18n"
  #require 'pickle'
  #DatabaseCleaner.clean_with(:truncation)
end

