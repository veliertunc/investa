class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :favoritable, polymorphic: true, counter_cache: :favorites_count
  validates :user_id, uniqueness: { scope: [ :favoritable_type, :favoritable_id ] }
end
