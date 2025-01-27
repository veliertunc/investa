class CreateStartups < ActiveRecord::Migration[8.0]
  def change
    create_table :startups do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :industry
      t.decimal :funding_goal
      t.decimal :equity_offered
      t.string :website_url

      t.timestamps
    end
  end
end
