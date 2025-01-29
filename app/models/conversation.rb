class Conversation < ApplicationRecord
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"
  has_many :messages, dependent: :destroy

  validates :user1, uniqueness: { scope: :user2 }
  validate :different_users

  def self.between(user1, user2)
    sorted_users = [ user1, user2 ].sort_by(&:id)
    find_or_create_by(user1: sorted_users.first, user2: sorted_users.last)
  end

  def participants
    [ user1, user2 ]
  end

  def other_user(current_user)
    user1 == current_user ? user2 : user1
  end

  private

  def different_users
    errors.add(:base, "Cannot message yourself") if user1 == user2
  end
end
