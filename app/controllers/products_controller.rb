class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
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
  end

  def show
    @user = User.find_by(id: @product.user_id)
    @reviews = @product.reviews_with_id.order(created_at: :desc)
    @review = @reviews.new
    @star_repeat_select = Review.star_repeat_select
  end

  def new
    @product = current_user.products.new
    @categories = Category.all
    @tastes = Taste.all
    @genres = Genre.all
    @product_star_repeat_select = Product.star_repeat_select
  end

  def create
    @product = current_user.products.new(product_params)
    
    if @product.save
      redirect_to root_path, notice: "投稿に成功しました"
    else
      redirect_to new_product_path, alert: "投稿に失敗しました"
    end
  end

  def edit
    @categories = Category.all
    @tastes = Taste.all
    @genres = Genre.all
    @product_star_repeat_select = Product.star_repeat_select
  end

  def update
    if @product.update(product_params)
      redirect_to mypage_myposts_users_path, notice: "投稿をアップデートしました"
    else
      redirect_to edit_product_path(product), alert: "アップデートに失敗しました"
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end
  
  private
  
    def set_product
      @product = Product.find_by(id: params[:id])
      redirect_to(products_url, alert: "ERROR!!") if @product.blank?
    end
    
    def product_params
      params.require(:product).permit( :name, :description, :price, :category_id, :taste_id, :recommend, :instagram, :user_id, :company, :genre_id, images: [])
    end
    
    def sort_params
      params.permit(:sort, :sort_genre)
    end
end
