ActiveAdmin.register User do
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :role
  includes :startup, :investor_profile, :investment_proposals, :favorites, :favorited_items

  permit_params do
    permitted = [ :email, :role ]
    permitted << :password if params[:action] == "create" && current_user.admin?
    permitted << :password_confirmation if params[:action] == "create" && current_user.admin?
    permitted
  end

  filter :email
  filter :role
  filter :created_at
  filter :updated_at

  actions :all, except: []

  index do
    selectable_column
    column :email
    column :role
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs "Login Info" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end


  controller do
    def create
      @user = User.new(permitted_params[:user])

      if @user.save
        puts "User created successfully"
      end
    end
  end
end
