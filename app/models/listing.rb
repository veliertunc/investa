class Listing < ApplicationRecord
  belongs_to :startup
  enum :status, [ :active, :funded, :closed ]
end
