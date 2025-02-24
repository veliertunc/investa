ActiveAdmin.register Startup do
  # permit_params :user_id, :name, :description, :industry, :funding_goal, :equity_offered, :website_url, :address, :latitude, :longitude

  permit_params do
    permitted = [ :user_id, :name, :description, :industry, :funding_goal, :equity_offered, :website_url ]
    permitted
  end

  filter :name
  filter :description
  filter :industry
  filter :funding_goal
  filter :equity_offered

  actions :all, except: []
end
