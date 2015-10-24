ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'bacvashop@gmail.com', #ENV['SENDGRID_USERNAME'],
  :password       => 'zicakv12',            #ENV['SENDGRID_PASSWORD'],
  :domain         => 'gmail.com'
}
ActionMailer::Base.delivery_method = :smtp