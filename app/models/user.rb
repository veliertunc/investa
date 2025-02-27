class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum :role, [ :founder, :investor ]

  # Associations
  has_one :startup, dependent: :destroy
  has_one :investor_profile, dependent: :destroy
  has_many :investment_proposals, through: :investor_profile

  # Mailboxer
  acts_as_messageable

  # Favorites feature
  has_many :favorites, dependent: :destroy
  has_many :favorited_items, through: :favorites, source: :bookmarkable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true


  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "role", "created_at", "updated_at" ]
  end

  def name
    if self.founder?
      if self.startup.present?
        self.startup.name
      else
        "Unknown Startup ##{id}"
      end
    elsif self.investor?
      if self.investor_profile.present?
        self.investor_profile.name
      else
        "Unknown Investor ##{id}"
      end
    else
      "Unknown User ##{id}"
    end
  end

  def mailboxer_email(object)
    object.is_a?(Mailboxer::Message) ? self.email : nil
  end

  def conversations
    self.mailbox.conversations
  end

  def notifications
    self.mailbox.notifications
  end

  def unread_conversations
    list = self.conversations.select do |conversation|
      conversation.is_unread?(self)
    end
    list
  end

  def unread_messages
    list = self.unread_conversations.flat_map do |conversation|
      conversation.receipts_for(self).where(is_read: false).map(&:notification)
    end
    list
  end
end
