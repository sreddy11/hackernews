class LoginsController < ApplicationController
  
  before_filter :require_no_authentication, :only => [:new, :create]
  before_filter :previous_page, :only => [:new, :destroy]
  
  def new
  end

  def create
    @user = User.find_by_user_name(login_params[:user_name])
    if @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Login Successful"
      redirect_to(session[:return_page])
    else
      flash.now[:error] = "Login Invalid"
      render(:new)
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout Successful"
    redirect_to(session[:return_page])
  end

  private

  def login_params 
    params[:login] || {}
  end

  def previous_page
      session[:return_page] = request.referer
  end

end
