class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_filter :authenticate_user!, only: [:index, :show]
  
  respond_to :html, :js
  
  layout 'application'

  def index
    @users = User.where("id != ?", current_user.id)
  end

  def show
    mess1 = Message.where(sender_id: current_user.id, recipient_id: params[:id].to_i)
    mess2 = Message.where(sender_id: params[:id].to_i, recipient_id: current_user.id)
    @messages = (mess1 + mess2).sort_by{|e| e[:created_at]}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
    else
      render :new
    end
  end
  
  def check_online
    @users = User.where("id != ?", current_user.id)
    @online = online_users
    respond_to :js
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email)
    end
    
    def message_params
      params.require(:message).permit(:body)
    end
end
