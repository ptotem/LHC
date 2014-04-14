ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => "letshavecoffee.in",
    :user_name => "contact@letshavecoffee.in",
    :password => "password105957",
    :authentication => "plain",
    :enable_starttls_auto => true
}

