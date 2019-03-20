# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SMTP_USERNAME'],
  :password => ENV['SMTP_PASSWORD'],
  :domain => ENV['SMTP_DOMAIN'],
  :address => ENV['SMTP_ADDRESS'],
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true


ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
