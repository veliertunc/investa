class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.references :startup, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :funding_goal, precision: 15, scale: 2
      t.decimal :equity_offered, precision: 5, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
