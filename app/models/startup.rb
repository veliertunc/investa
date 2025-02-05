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
  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :website_url, presence: true, format: { with: URL_REGEXP, message: "You provided an invalid URL" }

  before_validation :fix_url
  # validates :website_url, presence: true
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

  private

  def fix_url
    self.website_url = "https://#{self.website_url}" unless self.website_url.start_with?("http")
  end
end
