class MonetizeListing < ActiveRecord::Migration[8.0]
  def change
    remove_column :listings, :funding_goal, :integer, if_exists: true
    add_monetize :listings, :funding_goal
  end
end
