class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum :role, [ :founder, :investor ]

  # Associations
  has_one :startup, dependent: :destroy
  has_one :investor_profile, dependent: :destroy
  has_many :conversations_as_user1, class_name: "Conversation", foreign_key: :user1_id
  has_many :conversations_as_user2, class_name: "Conversation", foreign_key: :user2_id
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :investment_proposals, through: :investor_profile
  has_many :favorites
  has_many :favorited_items, through: :favorites, source: :favoritable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  def conversations
    Conversation.where("user1_id = ? OR user2_id = ?", id, id)
  end
end
