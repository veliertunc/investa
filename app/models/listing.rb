class Listing < ApplicationRecord
  belongs_to :startup
  has_many :investment_proposals, dependent: :destroy

  enum status: { active: 0, funded: 1, closed: 2 }, _prefix: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 50, maximum: 2000 }
  validates :funding_goal, numericality: { greater_than: 0 }
  validates :equity_offered, numericality: {
    greater_than_or_equal_to: 0.1,
    less_than_or_equal_to: 100,
    message: "must be between 0.1% and 100%"
  }

  scope :active, -> { where(status: :active) }
  scope :recent, -> { order(created_at: :desc) }

  def total_investments
    investment_proposals.sum(:amount)
  end

  def remaining_amount
    funding_goal - total_investments
  end

  def equity_remaining
    equity_offered - investment_proposals.sum(:equity_requested)
  end
end
