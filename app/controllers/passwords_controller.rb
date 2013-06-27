class PasswordsController < ApplicationController
  
  before_filter :find_user_by_password_reset_token, :only => [:edit,:update]
  before_filter :check_expired, :only => [:edit,:update]
  
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset    
      redirect_to articles_path, :notice => "E-mail has been sent regarding resetting password."
    else 
      redirect_to articles_path, :notice => "No account matches the e-mail provided."
    end
  end

  def edit
  end

  def update
    if params[:user][:password].length >=6  
      if @user.update_attributes(params[:user])
        redirect_to articles_path, :notice => "Password has been reset!"
        @user.update_attribute(:reset_password_token, nil)
      else
        flash.now[:alert] = "Password did not update. Please try again."
        render :edit       
      end
    else
      flash.now[:alert] = "Password did not meet requirements. Please try again."
      render :edit
    end
  end
  
  def new
  end

  private

  def find_user_by_password_reset_token
    @user = User.find_by_reset_password_token!(params[:token])
  end

  def check_expired
    if @user.reset_password_sent_at < 4.hours.ago
      redirect_to new_password_path, :alert => "Password reset has expired."
    end  
  end
end
