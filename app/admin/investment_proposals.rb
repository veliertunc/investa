ActiveAdmin.register InvestmentProposal do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :listing_id, :investor_profile_id, :amount, :equity_requested, :status
  #
  # or
  #
  belongs_to :listing
  belongs_to :investor_profile

  permit_params do
    permitted = [ :amount, :equity_requested, :status ]
    permitted << :other if params[:action] == "create" && current_user.admin?
    permitted
  end

  filter :amount
  filter :equity_requested
  filter :status

  actions :all, except: []
end
