class AddFavoritesCountToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :favorites_count, :integer, default: 0
  end
end
