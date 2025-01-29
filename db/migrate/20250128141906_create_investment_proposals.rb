class CreateInvestmentProposals < ActiveRecord::Migration[8.0]
  def change
    create_table :investment_proposals do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :investor_profile, null: false, foreign_key: true
      t.decimal :amount
      t.decimal :equity_requested
      t.text :message
      t.integer :status

      t.timestamps
    end
  end
end
