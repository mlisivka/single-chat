class AuthenticationsController < ApplicationController
  
  skip_before_filter :authenticate_user!
  
  def facebook
    puts request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    log_in(@user)
    redirect_to root_path
  end
  
  def vk
    puts request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    log_in(@user)
    redirect_to root_path
  end

  def failure
    redirect_to root_path
  end
end