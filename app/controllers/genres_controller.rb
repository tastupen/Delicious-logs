class GenresController < ApplicationController
  def index
    @major_category_names = Genre.major_categories
    @genres = Genre.all
  end
end
