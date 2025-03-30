class ChangeMonetizeLimits < ActiveRecord::Migration[8.0]
  def change
    change_column :startups, :funding_goal_cents, :integer, limit: 8
    change_column :listings, :funding_goal_cents, :integer, limit: 8
    change_column :investment_proposals, :amount_cents, :integer, limit: 8
  end
end
