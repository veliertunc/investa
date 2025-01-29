class CreateInvestmentProposals < ActiveRecord::Migration[8.0]
  def change
    create_table :investment_proposals do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :investor_profile, null: false, foreign_key: true
      t.decimal :amount, precision: 15, scale: 2
      t.decimal :equity_requested, precision: 5, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
