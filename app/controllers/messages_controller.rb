class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = current_user.conversations.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params.merge(user: current_user))

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
