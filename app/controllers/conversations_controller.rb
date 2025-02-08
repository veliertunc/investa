class ConversationsController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_messages_as_read, only: [ :show ]

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
  end

  def new
    @recipients = User.all - [ current_user ]
  end

  def create
    recipient = User.find(params[:user_id])
    message_body = params[:message][:body]
    subject = params[:subject]
    # Debug: log the type to ensure it's a string
    Rails.logger.debug "Message body class: #{message_body.class}"  # Should output String

    receipt = current_user.send_message(recipient, message_body, subject)
    redirect_to conversation_path(receipt.conversation), notice: "Message sent successfully"
  end

  private

  def mark_messages_as_read
    @conversation.mark_as_read(current_user)
  end
end
