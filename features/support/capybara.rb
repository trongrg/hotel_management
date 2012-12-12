require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'

Capybara.default_selector = :css
# Capybara.javascript_driver = :webkit
Capybara.javascript_driver = :selenium
Capybara.default_wait_time = 10
