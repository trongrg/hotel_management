require "compass"
require "sassy-buttons"
Rails.configuration.sass.tap do |config|
  config.load_paths << "#{Gem.loaded_specs['compass'].full_gem_path}/frameworks/compass/stylesheets"
  config.load_paths << "#{Gem.loaded_specs['sassy-buttons'].full_gem_path}/stylesheets"
end
