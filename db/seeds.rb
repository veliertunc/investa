# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Founders
founder = User.create!(
  email: "founder@example.com",
  password: "password",
  role: "founder"
)
startup = founder.create_startup!(
  name: "Tech Innovators",
  description: "Revolutionizing the tech industry",
  industry: "Technology",
  funding_goal: 1_000_000
)

# Investors
investor = User.create!(
  email: "investor@example.com",
  password: "password",
  role: "investor"
)
investor_profile = investor.create_investor_profile!(
  name: "VC Firm",
  bio: "Investing in innovative tech startups",
  investment_preferences: "Seed to Series A tech startups"
)

# Listings
startup.listings.create!(
  title: "Seed Round Funding",
  description: "Looking for seed investment to expand operations",
  funding_goal: 500_000,
  equity_offered: 20,
  status: :active
)
