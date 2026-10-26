class InvestmentProposal < ApplicationRecord
  belongs_to :listing
  belongs_to :investor_profile
  has_one :investor, through: :investor_profile, source: :user

  enum :status, [ :pending, :accepted, :rejected ]
  # validates :amount, numericality: { greater_than_or_equal_to: 0.01 }
  monetize :amount_cents, numericality: { greater_than_or_equal_to: 0.01 }, limit: 8

  validates :equity_requested, numericality: {
    greater_than_or_equal_to: 0.01,
    less_than_or_equal_to: 100
  }
  validates :amount_currency, inclusion: { in: ->(proposal) { [ proposal.listing&.funding_goal_currency ] } }, if: -> { listing.present? }
  validate :within_listing_limits
  validate :listing_accepts_proposals

  scope :startup_proposals, ->(startup) { joins(listing: [ :startup ]).where("startup_id = ?", startup) }

  def accept
    return false unless pending?

    accepted = false
    listing.with_lock do
      reload
      return false unless pending?

      unless listing.active?
        errors.add(:listing, "is no longer accepting proposals")
        raise ActiveRecord::Rollback
      end

      if amount_cents > listing.remaining_amount
        errors.add(:amount, "exceeds listing's remaining funding goal")
        raise ActiveRecord::Rollback
      end

      if equity_requested > listing.equity_remaining
        errors.add(:equity_requested, "exceeds listing's available equity")
        raise ActiveRecord::Rollback
      end

      update!(status: :accepted)
      listing.update!(status: :funded) if listing.remaining_amount <= 0
      accepted = true
    end
    accepted
  rescue ActiveRecord::RecordInvalid
    false
  end

  def reject
    return false unless pending?

    listing.with_lock do
      reload
      update!(status: :rejected) if pending?
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "listing_id", "investor_profile_id", "amount", "equity_requested", "status", "created_at", "updated_at" ]
  end

  private

  def within_listing_limits
    return unless listing

    if amount_cents > listing.remaining_amount
      errors.add(:amount, "exceeds listing's remaining funding goal")
    end

    if equity_requested > listing.equity_remaining
      errors.add(:equity_requested, "exceeds listing's available equity")
    end
  end

  def listing_accepts_proposals
    errors.add(:listing, "is not accepting proposals") if listing && !listing.active? && new_record?
  end

end
