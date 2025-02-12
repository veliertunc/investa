ActiveAdmin.register Listing do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :startup_id, :title, :description, :funding_goal, :equity_offered, :status, :favorites_count
  #
  # or
  #
  belongs_to :startup

  permit_params do
    permitted = [ :title, :description, :funding_goal, :equity_offered, :status ]
    permitted << :other if params[:action] == "create" && current_user.admin?
    permitted
  end

  filter :title
  filter :description
  filter :funding_goal
  filter :equity_offered
  filter :status

  actions :all, except: []
end
