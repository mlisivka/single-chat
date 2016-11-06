class MessagesController < ApplicationController

  respond_to :html, :js
  
  def create
    @message           = Message.new(message_params)
    @message.sender    = current_user
    @message.recipient = User.find(params[:id])
    
    if @message.save
      sync_new @message
    end
    
    respond_to do |format|
      format.html
      format.js { render json: @user }
    end
  end
  
  def message_params
    params.require(:message).permit(:body)
  end
  
end
