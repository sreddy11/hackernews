class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  private

  def render_404
    render "public/404", :formats => [:html], :status => :not_found
  end
    
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
    unless logged_in?
      session[:return_page] = request.fullpath
      flash[:error] = "Please login first"
      redirect_to(login_path)
    end 
  end

  def require_no_authentication
    if session[:return_page] == nil
      session[:return_page] == request.referer
    end
    if logged_in?
      flash[:error] = "Already logged in"
      redirect_to(request.referer)
    end 
  end
 
end
