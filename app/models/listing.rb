class Listing < ApplicationRecord
  # NOTE: The startup founder publishes a listing that says
  # I will give this much equity. This class holds that information
  # Later, investors send proposals for any listing
  belongs_to :startup
  has_many :investment_proposals, dependent: :destroy
  has_many :favorites, as: :favoritable
  has_many :favorited_by, through: :favorites, source: :user

  enum :status, [ :active, :funded, :closed ]

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20, maximum: 2000 }
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

  def self.ransortable_attributes(auth_object = nil)
    %w[title created_at funding_goal equity_offered status]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[startup]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title description funding_goal equity_offered status created_at]
  end
end
