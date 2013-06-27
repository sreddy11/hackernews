class ResetPasswordsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset    
      redirect_to articles_path, :notice => "E-mail has been sent regarding resetting password"
    else 
      redirect_to articles_path, :notice => " No account matches the email provided"
    end
  end

  def edit
    @user = User.find_by_reset_password_token!(params[:id])
  end

  def update
    @user = User.find_by_reset_password_token!(params[:id])
    if @user.reset_password_sent_at < 4.hours.ago
      redirect_to new_reset_password_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to articles_path, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
  
  def new
  end
end
