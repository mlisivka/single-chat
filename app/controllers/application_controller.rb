class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  after_action :set_online
  
  def log_in(user)
    session[:user_id] = user.id
    set_online
  end
  
  def log_out
    set_offline(session[:user_id])
    session.delete(:user_id)
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def authenticate_user!
    unless session[:user_id]
      redirect_to login_path
    end
  end
  
  def online_users
    $redis.keys
  end
  
  private

  def set_online
    if current_user
      $redis.set( current_user.id, nil, ex: 300 )
    end
  end
  
  def set_offline(user_id)
    $redis.del(user_id)
  end
    
end
