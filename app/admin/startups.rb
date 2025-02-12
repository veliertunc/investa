ActiveAdmin.register Startup do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :name, :description, :industry, :funding_goal, :equity_offered, :website_url, :address, :latitude, :longitude
  #
  # or
  #
  belongs_to :user

  permit_params do
    permitted = [ :name, :description, :industry, :funding_goal, :equity_offered, :website_url ]
    permitted << :other if params[:action] == "create" && current_user.admin?
    permitted
  end

  filter :name
  filter :description
  filter :industry
  filter :funding_goal
  filter :equity_offered

  actions :all, except: []
end
