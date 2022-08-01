class Favorite 
  attr_reader :photo,
              :title,
              :other_titles,
              :details,
              :id,
              :location_id,
              :pdf
  def initialize(attributes)
    require 'pry'; binding.pry
    @photo        = attributes[:medium_photo]
    @title        = attributes[:title]
    @other_titles = attributes[:other_titles]
    @details      = attributes[:details]
    @id           = attributes[:id]
    @location_id  = attributes[:location_id]
    @pdf          = attributes[:pdf]
  end
end