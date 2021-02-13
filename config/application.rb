require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CbMorning
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = 'Tokyo'

    config.i18n.default_locale = :ja

    config.generators do |g|
      g.view_specs false
      g.controller_specs false
      g.helper_specs false
      g.routing_specs false
      g.request_specs false
      g.assets false
      g.helper false
    end
  end
end
