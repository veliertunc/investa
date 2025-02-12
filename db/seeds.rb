# Clear existing data
[ User, Startup, InvestorProfile, Listing, InvestmentProposal, AdminUser ].each(&:destroy_all)

admin1 = AdminUser.create!(
  email: "admin1@example.com",
  password: "password"
)

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
  # address: '1 Hacker Way, Menlo Park, CA'
)

startup2 = founder2.create_startup!(
  name: 'Green Energy Solutions',
  description: 'Sustainable energy solutions for the future',
  industry: 'Clean Energy',
  funding_goal: 500_000,
  equity_offered: 20.0
  # address: '3500 Deer Creek Road, Palo Alto, CA'
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

# Create investment proposals
proposal1 = listing1.investment_proposals.create!(
  investor_profile: investor_profile1,
  amount: 250_000,
  equity_requested: 5.0,
  status: :pending
)

proposal2 = listing2.investment_proposals.create!(
  investor_profile: investor_profile2,
  amount: 1_000_000,
  equity_requested: 7.5,
  status: :pending
)

# Create conversations and messages

receipt1 = investor1.send_message(founder1, "Can I learn more about products and services you offer?", "About Your Platform")
founder1.reply_to_conversation(receipt1.conversation, "We focus on developing generative AI solutions for media industry")

receipt2 = investor2.send_message(founder2, "Would you consider increasing the equity you offer by %5 in exchange for $50000", "Request To Increase Equity")
founder2.reply_to_conversation(receipt2.conversation, "Thanks for your interest in our startup. Unfortunately, we are not planning to Increase it anymore")

# Output seed results
puts "Seeded #{User.count} users"
puts "Seeded #{Startup.count} startups"
puts "Seeded #{Listing.count} listings"
puts "Seeded #{InvestmentProposal.count} proposals"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
