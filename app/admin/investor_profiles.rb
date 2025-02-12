ActiveAdmin.register InvestorProfile do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :name, :bio, :investment_preferences
  #
  # or
  #
  belongs_to :user

  permit_params do
    permitted = [ :name, :bio, :investment_preferences ]
    permitted << :other if params[:action] == "create" && current_user.admin?
    permitted
  end

  filter :name
  filter :investment_preferences

  actions :all, except: []
end
