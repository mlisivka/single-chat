class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  # set online status after click to action
  after_action :set_online
  
  def log_in(user)
    session[:user_id] = user.id
    # set status to online
    set_online
  end
  
  def log_out
    # set status to offline
    set_offline
    session.delete(:user_id)
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # redirect on login page if user not authenticate
  def authenticate_user!
    unless current_user
      redirect_to login_path
    end
  end
  
  # all online users
  def online_users
    $redis.keys
  end
  
  private

  # chenged user status to online
  def set_online
    if current_user
      # set status duration 5 min
      # after redis delete this record and user will be offline status
      $redis.set( current_user.id, nil, ex: 300 )
    end
  end
  
  # chenged user status to offline
  def set_offline
    $redis.del(session[:user_id])
  end
    
end
