class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  def logged_in?
    session[:user_id] != nil
  end
  helper_method(:logged_in?)
  
  def current_user

    if User.exists?(session[:user_id])
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end
  helper_method(:current_user)
  
  def require_authentication
    if !logged_in?
      session[:return_page] = request.referer
      flash[:error] = "Please login first"
      redirect_to(new_login_path)
    end 
  end

  def require_no_authentication
    if logged_in?
      session[:return_page] = request.referer
      flash.now[:error] = "Already logged in"
      redirect_to(session[:return_page])
    end 
  end
 
end
