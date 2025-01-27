json.extract! investor_profile, :id, :user_id, :name, :bio, :investment_preferences, :created_at, :updated_at
json.url investor_profile_url(investor_profile, format: :json)
