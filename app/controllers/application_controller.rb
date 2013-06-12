class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  def logged_in?
    session[:user_id] != nil
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  helper_method(:current_user)
    
  helper_method(:logged_in?)

end
