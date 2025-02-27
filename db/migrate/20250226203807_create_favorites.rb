class CreateFavorites < ActiveRecord::Migration[8.0]
  def change
    drop_table :favorites if table_exists?(:favorites)
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bookmarkable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
