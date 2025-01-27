class CreateInvestorProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :investor_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :bio
      t.text :investment_preferences

      t.timestamps
    end
  end
end
