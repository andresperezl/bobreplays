require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bobreplays
  class Application < Rails::Application
    Rails.application.config.assets.precompile += %w( home.js home.css videos.css videos.js )
    config.active_record.raise_in_transactional_callbacks = true
  end
end
