class MonetizeStartup < ActiveRecord::Migration[8.0]
  def change
    remove_column :startups, :funding_goal, :integer, if_exists: true
    add_monetize :startups, :funding_goal
  end
end
