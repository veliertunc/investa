class User < ApplicationRecord
  enum :role, [ :founder, :investor ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :startup, dependent: :destroy
  has_one :investor_profile, dependent: :destroy
  has_many :conversations_as_user1, class_name: "Conversation", foreign_key: :user1_id
  has_many :conversations_as_user2, class_name: "Conversation", foreign_key: :user2_id
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def conversations
    Conversation.where("user1_id = ? OR user2_id = ?", id, id)
  end
end
