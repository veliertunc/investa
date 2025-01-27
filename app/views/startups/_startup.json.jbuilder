json.extract! startup, :id, :user_id, :name, :description, :industry, :funding_goal, :equity_offered, :website_url, :created_at, :updated_at
json.url startup_url(startup, format: :json)
