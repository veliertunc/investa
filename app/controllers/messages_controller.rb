class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation
  # before_create :sanitize_params

  def create
    # NOTE: params[:message][:body] is vulnerable to XSS attacks. Sanitize it first
    receipt = current_user.reply_to_conversation(@conversation, message_params)
    redirect_to conversation_path(receipt.conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_conversation
    @conversation = current_user.conversations.find(params[:conversation_id])
  end

  # def sanitize_params
  #   body = params[:body]
  # end
end
