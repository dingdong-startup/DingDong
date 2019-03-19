# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.configure do

config.action_mailer.smtp_settings = {
  address: ENV.fetch("SMTP_ADDRESS"),
  authentication: :plain,
  domain: ENV.fetch("SMTP_DOMAIN"),
  enable_starttls_auto: true,
  password: ENV.fetch("SMTP_PASSWORD"),
  port: "587",
  user_name: ENV.fetch("SMTP_USERNAME")
}
config.action_mailer.default_url_options = { host: ENV["SMTP_DOMAIN"] }

end
