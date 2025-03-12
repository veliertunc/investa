class AddRoleToAdminUser < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :role, :integer, default: 0, if_not_exists: true
  end
end
