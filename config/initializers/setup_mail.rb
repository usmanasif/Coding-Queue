# ActionMailer::Base.smtp_settings = {
#     :address              => "smtp.gmail.com",
#     :port                 => 587,
#     :domain               => "devsinc.com",
#     :user_name            => "ahmed.zubair",
#     :password             => "az4473011",
#     :authentication       => "plain",
#     :enable_starttls_auto => true
# }

ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 25,
    :domain               => "www.gmail.com",
    :user_name            => "usmantest@devsinc.com",
    :password             => "helloworld81",
    :authentication       => "plain",
    :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000"