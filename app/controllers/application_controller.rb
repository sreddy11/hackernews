class ApplicationController < ActionController::Base
  protect_from_forgery

  EmailVerifier.config do |config|
      config.verifier_email = "realname@realdomain.com"
  end

end
