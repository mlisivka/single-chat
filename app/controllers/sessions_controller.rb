class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.where(email:params[:session][:email]).first
    if user
      log_in(user)
      redirect_to root_path
    else
      render :new
    end
  end
  
  def destroy
    log_out
  end
end
