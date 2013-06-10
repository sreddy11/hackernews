module AuthHelper
  def authenticate(user = "sreddy1", password = "password")
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,password)
  end
end

