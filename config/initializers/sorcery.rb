 # The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:remember_me, :external]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  # -- core --
  # What controller action to call for non-authenticated users. You can also
  # override the 'not_authenticated' method of course.
  # Default: `:not_authenticated`
  #
  # config.not_authenticated_action =


  # When a non logged in user tries to enter a page that requires login, save
  # the URL he wanted to reach, and send him there after login, using 'redirect_back_or_to'.
  # Default: `true`
  #
  # config.save_return_to_url =


  # Set domain option for cookies; Useful for remember_me submodule.
  # Default: `nil`
  #
  # config.cookie_domain =


  # -- session timeout --
  # How long in seconds to keep the session alive.
  # Default: `3600`
  #
  # config.session_timeout =


  # Use the last action as the beginning of session timeout.
  # Default: `false`
  #
  # config.session_timeout_from_last_action =


  # -- http_basic_auth --
  # What realm to display for which controller name. For example {"My App" => "Application"}
  # Default: `{"application" => "Application"}`
  #
  # config.controller_to_realm_map =


  # -- activity logging --
  # will register the time of last user login, every login.
  # Default: `true`
  #
  # config.register_login_time =


  # will register the time of last user logout, every logout.
  # Default: `true`
  #
  # config.register_logout_time =


  # will register the time of last user action, every action.
  # Default: `true`
  #
  # config.register_last_activity_time =


  # -- external --
  # What providers are supported by this app, i.e. [:twitter, :facebook, :github, :google, :liveid] .
  # Default: `[]`
  #
  config.external_providers = [:twitter, :facebook, :github, :google, :livewire]



  # You can change it by your local ca_file. i.e. '/etc/pki/tls/certs/ca-bundle.crt'
  # Path to ca_file. By default use a internal ca-bundle.crt.
  # Default: `'path/to/ca_file'`
  #
  # config.ca_file =


  # Twitter wil not accept any requests nor redirect uri containing localhost,
  # make sure you use 0.0.0.0:3000 to access your app in development
  #

   config.twitter.key = "LOk9QB5O7raDYMRu1PJFw"
   config.twitter.secret = "LWvSx4YwsdEdmMa2SMvFBHxh4KXRcVIW0zc7lNprmY"
   config.twitter.callback_url = "http://localhost:3000/oauth/callback?provider=twitter"
   config.twitter.user_info_mapping = {:email => "name"}

  #
  
   config.facebook.key = "354034071331133"
   config.facebook.secret = "cd8b99eaeacb9ef610ad6aaff585208e"
   config.facebook.callback_url = "http://localhost:3000/oauth/callback?provider=facebook"
   config.facebook.user_info_mapping = {:email => "email"}

  #
   config.github.key = "33a4517b3f26294f955d"
   config.github.secret = "8d414ae05eff0d23623287fb25674fa5a8ea9661"
   config.github.callback_url = "http://localhost:3000/oauth/callback?provider=github"
   config.github.user_info_mapping = {:email => "name"}
  #
   config.google.key = "419021592963.apps.googleusercontent.com"
   config.google.secret = "3DCN7Qq_XCUbD7si-zcCnCgF"
   config.google.callback_url = "http://localhost:3000/oauth/callback?provider=google"
   config.google.user_info_mapping = {:email => "email"}

  #
  # To use liveid in development mode you have to replace mydomain.com with
  # a valid domain even in development. To use a valid domain in development
  # simply add your domain in your /etc/hosts file in front of 127.0.0.1
  #
  config.livewire.key = "71a588130e0b4c6c736302a5accac5e7f2a8519868b7cf5b9a8de9f25a989888"
  config.livewire.secret = "bb3712f2cd2e330ffc1daca638097f54f9b311154226b5a575b11bb553ad5d96"
  config.livewire.callback_url = "http://localhost:3000/"
  config.livewire.user_info_mapping = {:email => "fullname"}


  # --- user config ---
  config.user_config do |user|
    # -- core --
    # specify username attributes, for example: [:username, :email].
    # Default: `[:username]`
    #
     user.username_attribute_names =:email


    # change *virtual* password attribute, the one which is used until an encrypted one is generated.
    # Default: `:password`
    #
    # user.password_attribute_name =


    # downcase the username before trying to authenticate, default is false
    # Default: `false`
    #
    # user.downcase_username_before_authenticating =


    # change default email attribute.
    # Default: `:email`
    #
    # user.email_attribute_name =


    # change default crypted_password attribute.
    # Default: `:crypted_password`
    #
    # user.crypted_password_attribute_name =


    # what pattern to use to join the password with the salt
    # Default: `""`
    #
    # user.salt_join_token =


    # change default salt attribute.
    # Default: `:salt`
    #
    # user.salt_attribute_name =


    # how many times to apply encryption to the password.
    # Default: `nil`
    #
    # user.stretches =


    # encryption key used to encrypt reversible encryptions such as AES256.
    # WARNING: If used for users' passwords, changing this key will leave passwords undecryptable!
    # Default: `nil`
    #
    # user.encryption_key =


    # use an external encryption class.
    # Default: `nil`
    #
    # user.custom_encryption_provider =


    # encryption algorithm name. See 'encryption_algorithm=' for available options.
    # Default: `:bcrypt`
    #
    # user.encryption_algorithm =


    # make this configuration inheritable for subclasses. Useful for ActiveRecord's STI.
    # Default: `false`
    #
    # user.subclasses_inherit_config =


    # -- user_activation --
    # the attribute name to hold activation state (active/pending).
    # Default: `:activation_state`
    #
    # user.activation_state_attribute_name =


    # the attribute name to hold activation code (sent by email).
    # Default: `:activation_token`
    #
    # user.activation_token_attribute_name =


    # the attribute name to hold activation code expiration date.
    # Default: `:activation_token_expires_at`
    #
    # user.activation_token_expires_at_attribute_name =


    # how many seconds before the activation code expires. nil for never expires.
    # Default: `nil`
    #
    # user.activation_token_expiration_period =


    # your mailer class. Required.
    # Default: `nil`
    #
    # user.user_activation_mailer =
    
    
    # when true sorcery will not automatically
    # email activation details and allow you to
    # manually handle how and when email is sent.
    # Default: `false`
    #
    # user.activation_mailer_disabled = 


    # activation needed email method on your mailer class.
    # Default: `:activation_needed_email`
    #
    # user.activation_needed_email_method_name =


    # activation success email method on your mailer class.
    # Default: `:activation_success_email`
    #
    # user.activation_success_email_method_name =


    # do you want to prevent or allow users that did not activate by email to login?
    # Default: `true`
    #
    # user.prevent_non_active_users_to_login =


    # -- reset_password --
    # reset password code attribute name.
    # Default: `:reset_password_token`
    #
    # user.reset_password_token_attribute_name =


    # expires at attribute name.
    # Default: `:reset_password_token_expires_at`
    #
    # user.reset_password_token_expires_at_attribute_name =


    # when was email sent, used for hammering protection.
    # Default: `:reset_password_email_sent_at`
    #
    # user.reset_password_email_sent_at_attribute_name =


    # mailer class. Needed.
    # Default: `nil`
    #
    # user.reset_password_mailer =


    # reset password email method on your mailer class.
    # Default: `:reset_password_email`
    #
    # user.reset_password_email_method_name =


    # when true sorcery will not automatically
    # email password reset details and allow you to
    # manually handle how and when email is sent
    # Default: `false`
    #
    # user.reset_password_mailer_disabled =                                      

                                                                          
    # reset password email                                                                                   
    # method on your mailer
    # class.
    # Default: `:reset_password_email`
    #
    # user.reset_password_email_method_name =                            

                                                                                         
    # how many seconds before the reset request expires. nil for never expires.
    # Default: `nil`
    #
    # user.reset_password_expiration_period =


    # hammering protection, how long to wait before allowing another email to be sent.
    # Default: `5 * 60`
    #
    # user.reset_password_time_between_emails =


    # -- brute_force_protection --
    # Failed logins attribute name.
    # Default: `:failed_logins_count`
    #
    # user.failed_logins_count_attribute_name =


    # This field indicates whether user is banned and when it will be active again.
    # Default: `:lock_expires_at`
    #
    # user.lock_expires_at_attribute_name =


    # How many failed logins allowed.
    # Default: `50`
    #
    # user.consecutive_login_retries_amount_limit =


    # How long the user should be banned. in seconds. 0 for permanent.
    # Default: `60 * 60`
    #
    # user.login_lock_time_period =


    # -- activity logging --
    # Last login attribute name.
    # Default: `:last_login_at`
    #
    # user.last_login_at_attribute_name =


    # Last logout attribute name.
    # Default: `:last_logout_at`
    #
    # user.last_logout_at_attribute_name =


    # Last activity attribute name.
    # Default: `:last_activity_at`
    #
    # user.last_activity_at_attribute_name =


    # How long since last activity is he user defined logged out?
    # Default: `10 * 60`
    #
    # user.activity_timeout =


    # -- external --
    # Class which holds the various external provider data for this user.
    # Default: `nil`
    #
    user.authentications_class = Authentication



    # User's identifier in authentications class.
    # Default: `:user_id`
    #
    # user.authentications_user_id_attribute_name =


    # Provider's identifier in authentications class.
    # Default: `:provider`
    #
    # user.provider_attribute_name =


    # User's external unique identifier in authentications class.
    # Default: `:uid`
    #
    # user.provider_uid_attribute_name =
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
Rails.application.config.sorcery.submodules = [:remember_me, :external]

end
