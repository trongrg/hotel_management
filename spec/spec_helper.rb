require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require 'simplecov'

  require 'rails/application'
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include Devise::TestHelpers, :type => :controller
  end

  ActiveRecord::Base.connection.disconnect!
end

Spork.each_run do
  ActiveRecord::Base.establish_connection
  Dir[Rails.root.join("app/models/**/*.rb")].each {|f| load f}
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| load f}
end

