class AddMessageToInvestmentProposals < ActiveRecord::Migration[8.0]
  def change
    add_column :investment_proposals, :message, :text
  end
end
