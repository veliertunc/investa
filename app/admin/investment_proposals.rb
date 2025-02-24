ActiveAdmin.register InvestmentProposal do
  # permit_params :listing_id, :investor_profile_id, :amount, :equity_requested, :status

  permit_params do
    permitted = [ :listing_id, :investor_profile_id, :amount, :equity_requested, :status ]
    # permitted << :other if params[:action] == "create" && current_user.admin?
    permitted
  end

  filter :amount
  filter :equity_requested
  filter :status

  actions :all, except: []
end
