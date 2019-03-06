require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TradeNew
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
    config.load_defaults 5.1
    config.i18n.fallbacks = [I18n.default_locale]
    config.eager_load_paths += %W( #{config.root}/app/jobs )
    config.action_cable.allowed_request_origins = [APP_CONFIG['site_url']]
    config.active_job.queue_adapter = :sidekiq
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
