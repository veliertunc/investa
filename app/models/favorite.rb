class Favorite < ApplicationRecord
  BOOKMARKABLE_TYPES = %w[Listing].freeze
  delegated_type :bookmarkable, types: BOOKMARKABLE_TYPES
  belongs_to :user

  validates :user_id, uniqueness: {
    scope: [ :bookmarkable_type, :bookmarkable_id ],
    message: "already favorited this item"
  }
end
