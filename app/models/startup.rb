class Startup < ApplicationRecord
  belongs_to :user
  has_many :listings, dependent: :destroy
  has_many :investment_proposals, through: :listings

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 50, maximum: 2000 }
  validates :industry, presence: true
  validates :funding_goal, numericality: { greater_than: 0 }
  validates :equity_offered, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  def total_funding_raised
    listings.sum(&:total_investments)
  end
end
