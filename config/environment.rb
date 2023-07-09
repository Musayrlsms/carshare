# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
  :password => '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', # This is the secret sendgrid API key which was issued during API key creation
  :domain => 'cambiy.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}