require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require 'simplecov'

  require 'rails/application'
  Spork.trap_method(Rails::Application, :reload_routes!)
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  # Prevent main application to eager_load in the prefork block (do not load files in autoload_paths)
  Spork.trap_method(Rails::Application, :eager_load!)

  # Below this line it is too late...
  require File.expand_path("../../config/environment", __FILE__)

  # Load all railties files
  Rails.application.railties.all { |r| r.eager_load! }

  require 'rspec/rails'

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include Devise::TestHelpers, :type => :controller
    config.before :each do
      Role.find_or_create_by_name("Admin")
      Role.find_or_create_by_name("Hotel Owner")
      Role.find_or_create_by_name("Staff")
    end
  end

  ActiveRecord::Base.connection.disconnect!
end

Spork.each_run do
  ActiveRecord::Base.establish_connection
  require 'machinist/active_record'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| load f}
  I18n.backend.reload!
end
