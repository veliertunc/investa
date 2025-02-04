class Startup < ApplicationRecord
  belongs_to :user
  has_many :listings, dependent: :destroy
  has_many :investment_proposals, through: :listings
  # geocoded_by :address
  # after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20, maximum: 2000 }
  validates :industry, presence: true
  validates :funding_goal, numericality: { greater_than: 0 }
  validates :equity_offered, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  # validates :address, presence: true

  def total_funding_raised
    listings.sum(&:total_investments)
  end

  def self.ransortable_attributes(auth_object = nil)
    %w[name industry funding_goal funding_goal equity_offered created_at]
  end

  # def self.ransackable_associations(auth_object = nil)
  #   %w[listings]
  # end

  def self.ransackable_attributes(auth_object = nil)
    %w[name industry funding_goal funding_goal equity_offered created_at]
  end
end
