require 'rubygems'
require 'spork'

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'

  if RUBY_VERSION > '1.9'
    require 'simplecov'
    SimpleCov.start 'rails' if ENV['COVERAGE']
    SimpleCov.coverage_dir 'coverage/rspec'
  end

  require 'rails/application'
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  # Prevent main application to eager_load in the prefork block (do not load files in autoload_paths)
  Spork.trap_method(Rails::Application, :eager_load!)

  # Below this line it is too late...
  require File.expand_path('../../config/environment', __FILE__)

  # Load all railties files
  Rails.application.railties.all { |r| r.eager_load! }

  require 'rspec/rails'
end

Spork.each_run do
  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| load f}
  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include Devise::TestHelpers, :type => :controller
    config.extend ControllerHelpers, :type => :controller
    config.order = 'random'
  end
  I18n.backend.reload!
end
