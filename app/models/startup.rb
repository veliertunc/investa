class Startup < ApplicationRecord
  include Fundable
  # Use Rails sanitizer (make sure ActionView is available in your context)
  include ActionView::Helpers::SanitizeHelper

  belongs_to :user
  has_many :listings, dependent: :destroy
  has_many :investment_proposals, through: :listings

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20, maximum: 2000 }
  validates :industry, presence: true
  validates :url, url: true, allow_blank: true

  # before_save :sanitize_and_format_url

  # after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  def total_funding_raised
    listings.sum(&:total_investments)
  end

  def self.ransortable_attributes(auth_object = nil)
    %w[name industry funding_goal equity_offered created_at updated_at]
  end


  def self.ransackable_associations(auth_object = nil)
    %w[user listings investment_proposals]
  end


  def self.ransackable_attributes(auth_object = nil)
    %w[name description industry funding_goal equity_offered created_at updated_at]
  end
end
