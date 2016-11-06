class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_filter :authenticate_user!, only: [:index, :show]
  
  respond_to :html, :js

  def index
    @users = User.where("id != ?", current_user.id)
  end

  def show
    @messages = Message.all
    @new_message = Message.new
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
  
  def create_message
    @message = current_user.messages.build(message_params)
    @message.sender    = current_user
    @message.recipient = User.find(params[:message][:recipient])

    if @message.save
      sync_new @message
    end
    
    render "show"
    #respond_with @message, location: request.referer

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
