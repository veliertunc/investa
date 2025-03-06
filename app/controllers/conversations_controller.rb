class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [ :show, :reply, :trash, :untrash ]
  before_action :sanitize_params, only: [ :create, :reply ]
  before_action :validate_recipient, only: [ :new ]


  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation.mark_as_read(current_user)
  end

  def new
    if params[:recipient_id]
      @recipient = User.find_by(id: params[:recipient_id])
      @recipients = [ @recipient ].compact
    else
      @recipients = User.excluding(current_user)
    end
  end

  def create
    recipient = User.find(params[:recipient_id])
    receipt = current_user.send_message(
      recipient,
      @sanitized_body,
      @sanitized_subject
    )
    redirect_to conversation_path(receipt.conversation)
  end

  def reply
    current_user.reply_to_conversation(@conversation, @sanitized_body)
    redirect_to conversation_path(@conversation)
  end

  def trash
    @conversation.move_to_trash(current_user)
    redirect_to conversations_path
  end

  def untrash
    @conversation.untrash(current_user)
    redirect_to conversations_path
  end

  private

  # Strong parameters for mass assignment (if using Rails form_with)
  def conversation_params
    params.require(:conversation).permit(:subject, :body, :recipient_id)
  end

  def sanitize_params
    # Sanitize parameters using Rails' built-in sanitization
    @sanitized_body = helpers.sanitize(params[:body])
    @sanitized_subject = helpers.sanitize(params[:subject])
  end

  def set_conversation
    @conversation = current_user.conversations.find(params[:id])
  end

  def validate_recipient
    return unless params[:recipient_id]

    @recipient = User.find_by(id: params[:recipient_id])
    return if @recipient && @recipient != current_user

    redirect_back_or_to fallback_location: dashboard_path
  end
end
