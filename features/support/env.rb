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

  # Prevent main application to eager_load in the prefork block (do not load files in autoload_paths)
  Spork.trap_method(Rails::Application, :eager_load!)

  # Below this line it is too late...
  require File.dirname(__FILE__) + "/../../config/environment.rb"

  # Load all railties files
  Rails.application.railties.all { |r| r.eager_load! }

  require 'cucumber/rails'
  Rails.env = 'cucumber'
end

Spork.each_run do
  require 'cucumber/rails/world'
  Dir[Rails.root.join("spec/support/blueprints/**/*.rb")].each { |f| load f }
  I18n.backend.reload!
  DatabaseCleaner.clean_with :truncation
end
