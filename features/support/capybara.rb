require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'

Capybara.default_selector = :css
Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 10

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
