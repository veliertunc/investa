class InvestmentProposal < ApplicationRecord
  belongs_to :listing
  belongs_to :investor_profile
  has_one :investor, through: :investor_profile, source: :user

  enum :status, [ :pending, :accepted, :rejected ]
  validates :amount, numericality: { greater_than_or_equal_to: 0.01 }
  validates :equity_requested, numericality: {
    greater_than_or_equal_to: 0.01,
    less_than_or_equal_to: 100
  }
  validate :within_listing_limits
  after_update_commit :update_listing_status, only: [ :accept ]

  scope :startup_proposals, ->(startup) { joins(listing: [ :startup ]).where("startup_id = ?", startup) }

  def accept
    update(status: :accepted) if self.pending?
  end

  def reject
    update(status: :rejected) if self.pending?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "listing_id", "investor_profile_id", "amount", "equity_requested", "status", "created_at", "updated_at" ]
  end

  private

  def within_listing_limits
    return unless listing

    if amount > listing.remaining_amount
      errors.add(:amount, "exceeds listing's remaining funding goal")
    end

    if equity_requested > listing.equity_remaining
      errors.add(:equity_requested, "exceeds listing's available equity")
    end
  end

  def update_listing_status
    listing.update(status: :funded) if listing.remaining_amount <= 0
  end
end
