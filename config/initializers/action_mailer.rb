Rails.application.configure do
config.action_mailer.smtp_settings = {
    :user_name => ENV['SMTP_USERNAME'],
    :password => ENV['SMTP_PASSWORD'],
    :domain => ENV['SMTP_DOMAIN'],
    :address => ENV['SMTP_ADDRESS'],
    :port => 25,
    :authentication => :login,
    :enable_starttls_auto => true
  }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default charset: "utf-8"
end
