module Fundable
  extend ActiveSupport::Concern

  included do
    validates :funding_goal, numericality: { greater_than_or_equal_to: 0.01 }
    validates :equity_offered, numericality: {
      greater_than_or_equal_to: 0.01,
      less_than_or_equal_to: 100,
      message: "must be between 0.01% and 100%"
    }
  end
end
