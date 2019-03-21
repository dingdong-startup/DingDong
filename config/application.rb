require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DingDong
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :fr
    # config.action_mailer.delivery_method = :mailjet
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "in-v3.mailjet.com",
      port: 587,
      user_name: ENV['MJ_APIKEY'],
      password: ENV['MJ_SK'],
      authentication: "plain"
    }
  end
end

