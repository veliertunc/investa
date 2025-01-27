class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.references :startup, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :funding_goal
      t.decimal :equity_offered
      t.integer :status

      t.timestamps
    end
  end
end
