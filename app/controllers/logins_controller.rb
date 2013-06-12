class LoginsController < ApplicationController
  
  def new
  end

  def create
    
    @user = User.find_by_user_name(login_params[:user_name])
    if @user && @user.authenticate(login_params[:password]) 
      
      if !(session[:logged_in]) 
        session[:user_id] = @user.id
        session[:logged_in] = true
        flash[:notice] = "Login Successful"
        redirect_to(articles_path)
      else
        flash.now[:error] = "A user is already logged in"
        render(:new)
      end
    else
      flash.now[:error] = "Login Invalid"
      render(:new)
    end
  end

  def destroy 
  
  
    session[:user_id] = nil
    session[:logged_in] = false
    flash[:notice] = "Logout Successful"
    redirect_to(articles_path)


  
  end

  private

  def login_params 
    params[:login] || {}
  end
end
