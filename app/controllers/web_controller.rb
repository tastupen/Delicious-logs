class WebController < ApplicationController
  
  PRODUCTS_PER_PAGE = 6

  def index
    if sort_params.present?
      @genre = Genre.request_genre(sort_params[:sort_genre])
      @products = Product.sort_products(sort_params, params[:page])
    elsif params[:genre].present?
      @genre = Genre.request_genre(params[:genre])
      @products = Product.genre_products(@genre, params[:page])
    else
      @products = Product.display_list(params[:page])
    end
    
    @major_category_names = Genre.major_categories
    @genres = Genre.all
    @user = current_user
    @sort_list = Product.sort_list
    @recently_products = Product.recently_products(PRODUCTS_PER_PAGE)
    @good_products = Product.order("RANDOM()").limit(6)
    @instagrams = Product.instagram_products(PRODUCTS_PER_PAGE)
  end
  
  private
    def sort_params
      params.permit(:sort, :sort_category)
    end
end
