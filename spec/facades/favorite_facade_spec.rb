require 'rails_helper'

RSpec.describe FavoriteFacade do 
  it 'creates poro for all favorites', :vcr do 
    user_id = 3 
    favorites = FavoriteFacade.get_favorites(user_id)

    expect(favorites.first).to be_a(Favorite)
  end

  it 'creates poro for new favorite', :vcr do
    user_id = 3
    data = { user_id: user_id,
             title: "1623 Market Street Denver CO",
             photo: "jpeg.url",
             location_id: "pk id",
             other_titles: "1225",
             details: "some details",
             pdf: "pdf"
           }
   
    new_favorite = FavoriteFacade.new_favorite(user_id, data)

    expect(new_favorite).to be_a(Favorite)
  end
end