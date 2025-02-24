class InvestorProfile < ApplicationRecord
  belongs_to :user
  has_many :investment_proposals, dependent: :destroy

  validates :name, presence: true
  validates :bio, presence: true, length: { minimum: 20 }
  validates :investment_preferences, presence: true

  after_create :set_default_name

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "user_id", "bio", "name", "investment_preferences", "created_at", "updated_at" ]
  end

  private

  def set_default_name
    update(name: user.email.split("@").first.titleize) if name.blank?
  end
end
