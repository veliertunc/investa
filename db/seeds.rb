# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
[ Conversation, User, Startup, InvestorProfile, Listing, Message, InvestmentProposal, Notification ].each(&:destroy_all)

# Create sample users
founder1 = User.create!(
  email: 'founder1@example.com',
  password: 'password',
  role: :founder
)

founder2 = User.create!(
  email: 'founder2@example.com',
  password: 'password',
  role: :founder
)

investor1 = User.create!(
  email: 'investor1@example.com',
  password: 'password',
  role: :investor
)

investor2 = User.create!(
  email: 'investor2@example.com',
  password: 'password',
  role: :investor
)

# Create startups
startup1 = founder1.create_startup!(
  name: 'Tech Innovators',
  description: 'Revolutionizing the tech industry with AI solutions',
  industry: 'Artificial Intelligence',
  funding_goal: 1_000_000,
  equity_offered: 15.0
)

startup2 = founder2.create_startup!(
  name: 'Green Energy Solutions',
  description: 'Sustainable energy solutions for the future',
  industry: 'Clean Energy',
  funding_goal: 500_000,
  equity_offered: 20.0
)

# Create investor profiles
investor_profile1 = investor1.create_investor_profile!(
  name: 'John Venture',
  bio: 'Investing in tech startups with disruptive potential',
  investment_preferences: 'Seed to Series A, AI, CleanTech'
)

investor_profile2 = investor2.create_investor_profile!(
  name: 'Sarah Capital',
  bio: 'Focus on sustainable and social impact startups',
  investment_preferences: 'Social Impact, Clean Energy, Healthcare'
)

# Create listings
listing1 = startup1.listings.create!(
  title: 'Seed Round Funding',
  description: 'Looking for seed investment to expand AI platform development',
  funding_goal: 500_000,
  equity_offered: 10.0,
  status: :active
)

listing2 = startup2.listings.create!(
  title: 'Series A Funding',
  description: 'Scaling production of solar energy solutions',
  funding_goal: 2_000_000,
  equity_offered: 15.0,
  status: :active
)

# Create conversations and messages
conversation1 = Conversation.between(founder1, investor1)
message1 = conversation1.messages.create!(
  user: founder1,
  content: 'Hi John, interested in our AI platform?'
)
message2 = conversation1.messages.create!(
  user: investor1,
  content: 'Yes, let me review the details.'
)

# Create investment proposals
proposal1 = listing1.investment_proposals.create!(
  investor_profile: investor_profile1,
  amount: 250_000,
  equity_requested: 5.0,
  message: "We're impressed with your AI platform and would like to participate in this funding round. Our investment comes with industry connections and technical expertise.",
  status: :pending
)

proposal2 = listing2.investment_proposals.create!(
  investor_profile: investor_profile2,
  amount: 1_000_000,
  equity_requested: 7.5,
  message: "Your sustainability mission aligns perfectly with our investment thesis. We'd like to lead this round and help with scaling production.",
  status: :pending
)

# Create notifications
Notification.create!(
  user: founder1,
  message: 'New message from John Venture',
  link: conversation1
)

Notification.create!(
  user: founder2,
  message: 'New investment proposal received',
  link: listing2
)

puts "Seeded #{User.count} users"
puts "Seeded #{Startup.count} startups"
puts "Seeded #{Listing.count} listings"
puts "Seeded #{Conversation.count} conversations"
puts "Seeded #{Message.count} messages"
puts "Seeded #{InvestmentProposal.count} proposals"
puts "Seeded #{Notification.count} notifications"
