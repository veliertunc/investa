class Listing < ApplicationRecord
  # The startup founder publishes a listing that says I will give this much equity.
  # This class holds that information. Later, investors send proposals for any listing
  include Fundable
  include Bookmarkable

  # TODO: Convert belongs_to :startup association to polymorphic.
  # belongs_to :investable, polymorphic:true
  belongs_to :startup
  has_many :investment_proposals, dependent: :destroy

  enum :status, [ :active, :funded, :closed ]

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20, maximum: 2000 }

  scope :active, -> { where(status: :active) }
  scope :recent, -> { order(created_at: :desc) }

  def total_investments
    investment_proposals.accepted.sum(:amount_cents)
  end

  def remaining_amount
    funding_goal_cents - total_investments
  end

  def equity_remaining
    equity_offered - investment_proposals.sum(:equity_requested)
  end

  def self.ransortable_attributes(auth_object = nil)
    %w[title description funding_goal equity_offered status created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[startup investment_proposals]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title description funding_goal equity_offered status created_at updated_at]
  end
end
