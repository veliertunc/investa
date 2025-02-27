module FavoritesHelper
  def favorite_button(bookmarkable)
    if current_user.favorites.exists?(bookmarkable: bookmarkable)
      button_to "★",
                favorite_path(bookmarkable: { type: bookmarkable.class.name, id: bookmarkable.id }),
                method: :delete,
                class: "btn btn-md btn-favorite btn-primary"
    else
      button_to "☆",
                favorites_path(bookmarkable: { type: bookmarkable.class.name, id: bookmarkable.id }),
                method: :post,
                class: "btn btn-md btn-favorite"
    end
  end
end
