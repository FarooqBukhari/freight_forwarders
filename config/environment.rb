# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey',
    password: "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",
    :domain => 'https://send2world.herokuapp.com/',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}

