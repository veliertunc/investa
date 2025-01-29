class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
                                .includes(:user1, :user2, :messages)
                                .order(updated_at: :desc)
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    @message = Message.new
    mark_messages_as_read
  end

  def create
    recipient = User.find(params[:user_id])
    @conversation = Conversation.between(current_user, recipient)
    redirect_to conversation_path(@conversation)
  end

  private

  def mark_messages_as_read
    @conversation.messages.where.not(user: current_user).update_all(read_at: Time.current)
  end
end
