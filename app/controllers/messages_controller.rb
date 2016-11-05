class MessagesController < ApplicationController
  
  def create
    message           = Message.new
    message.sender    = current_user
    message.recipient = User.find(params[:recipient])
    message.body      = params[:body]
    message.save
    redirect_to user_path(params[:recipient])
  end
  
end
