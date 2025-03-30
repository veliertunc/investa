class MonetizeInvestmentProposal < ActiveRecord::Migration[8.0]
  def change
    remove_column :investment_proposals, :amount, :integer, if_exists: true
    add_monetize :investment_proposals, :amount
  end
end
