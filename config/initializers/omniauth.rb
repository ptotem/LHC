Rails.application.config.middleware.use OmniAuth::Builder do

  #configure do |config|
  #  config.path_prefix = '/auth'
  #end

  #LHC-dummy-app
  provider :facebook, "628824307167447", "ed2588abeb167627d4f12f1de1b3be6a"
           #:scope => 'email,user_birthday,read_stream', :display => 'popup'

end