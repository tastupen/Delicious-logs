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
    @genres = Genre.all.limit(20)
    @user = current_user
    @sort_list = Product.sort_list
    @recently_products = Product.recently_products(PRODUCTS_PER_PAGE)
    @good_products = Product.order("RANDOM()").limit(6)
    @instagrams = Product.instagram_products(PRODUCTS_PER_PAGE)
    @good_reviews = Product.find(Review.group(:product_id).order("RANDOM()").limit(6).pluck(:product_id))
    @likes = Product.find(Like.group(:product_id).order('count(product_id) desc').limit(6).pluck(:product_id))
  end
  
  private
    def sort_params
      params.permit(:sort, :sort_category)
    end
end
