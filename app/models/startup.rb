class Startup < ApplicationRecord
  # Use Rails sanitizer (make sure ActionView is available in your context)
  include ActionView::Helpers::SanitizeHelper
  # Regex to validate URLs that start with http:// or https://
  VALID_URL_REGEX = /\Ahttps?:\/\/[\S]+\z/

  belongs_to :user
  has_many :listings, dependent: :destroy
  has_many :investment_proposals, through: :listings
  # geocoded_by :address

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20, maximum: 2000 }
  validates :industry, presence: true
  validates :funding_goal, numericality: { greater_than_or_equal_to: 0.01 }
  validates :equity_offered, numericality: { greater_than_or_equal_ton: 0.01, less_than_or_equal_to: 100 }
  validates :website_url, format: { with: VALID_URL_REGEX, message: "must be a valid URL starting with http or https" }, allow_blank: true
  # validates :address, presence: true

  before_save :sanitize_and_format_url

  # after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  def total_funding_raised
    listings.sum(&:total_investments)
  end

  def self.ransortable_attributes(auth_object = nil)
    %w[name industry funding_goal funding_goal equity_offered created_at]
  end


  def self.ransackable_associations(auth_object = nil)
    %w[investment_proposals listings user]
  end


  def self.ransackable_attributes(auth_object = nil)
    %w[name description industry funding_goal funding_goal equity_offered created_at]
  end

  private

  # This method cleans the URL to remove unwanted HTML (XSS) and ensures a proper scheme
  def sanitize_and_format_url
    return if website_url.blank?

    # Sanitize to remove any HTML tags or attributes. This ensures that even if HTML or JS is injected,
    # it will be stripped out.
    cleaned_url = sanitize(website_url, tags: [], attributes: [])

    # Ensure the URL has a valid scheme. If not, prepend "https://"
    unless cleaned_url.match?(/\Ahttps?:\/\//)
      cleaned_url = "https://#{cleaned_url}"
    end

    self.website_url = cleaned_url
  end
end
