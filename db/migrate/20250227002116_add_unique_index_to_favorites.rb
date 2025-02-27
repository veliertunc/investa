class AddUniqueIndexToFavorites < ActiveRecord::Migration[8.0]
  def change
    add_index :favorites, [ :user_id, :bookmarkable_type, :bookmarkable_id ],
              unique: true,
              name: 'index_favorites_on_user_and_bookmarkable'
  end
end
