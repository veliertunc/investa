ActiveAdmin.register User do
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :role
  includes :startup, :investor_profile, :investment_proposals

  permit_params do
    permitted = [ :email, :role ]
    permitted << :password if params[:action] == "create" && current_user.admin?
    permitted
  end

  filter :email
  filter :role

  actions :all, except: []

  controller do
    def create
      @user = User.new(permitted_params[:user])

      if @user.save
        puts "Ok"
      end
    end
  end
end
