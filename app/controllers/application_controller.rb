class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  def logged_in?
    session[:user_id] != nil
  end
  helper_method(:logged_in?)
  
  def current_user
    @current_user ||= User.find(session[:user_id])
  end
  helper_method(:current_user)
  
  def require_authentication
    if !logged_in?
      flash[:error] = "Please login first"
      redirect_to(new_login_path)
    end 
  end

  def require_no_authentication
    if logged_in?
      flash[:error] = "Already logged in"
      redirect_to(articles_path)
    end 
  end
 
end
