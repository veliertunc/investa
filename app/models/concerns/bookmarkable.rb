module Bookmarkable
  extend ActiveSupport::Concern

  included do
    has_many :favorites, as: :bookmarkable, dependent: :destroy
  end

  def favorite_count
    favorites.count
  end
end
