# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


config.action_mailer.smtp_settings = {
    :address              => 'smtp.gmail.com',
    :port                 => 587,
    :domain               => 'heroku.com',
    :user_name            => 'bacvashop@gmail.com',
    :password             => 'zicakv12',
    :authentication       => 'plain',
    :enable_starttls_auto => true
}