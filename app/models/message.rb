class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create_commit :broadcast_message
  after_create :notify_recipient

  validates :content, presence: true, length: { minimum: 1, maximum: 2000 }

  def mark_as_read!
    update(read_at: Time.current) unless read?
  end

  def read?
    read_at.present?
  end

  private

  def broadcast_message
    ConversationChannel.broadcast_to(
      conversation,
      html: ApplicationController.render(
        partial: "messages/message",
        locals: { message: self, current_user: user }
      ),
      sender_id: user.id
    )
  end

  # TODO: Fix conversation path error
  def notify_recipient
    recipient = conversation.other_user(user)
    Notification.create(
      user: recipient,
      message: "New message from #{user.email}",
      link: conversation # Preeviously => link: conversation_path(conversation)
    )
  end
end
