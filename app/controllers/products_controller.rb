class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Product.display_list(genre_params, params[:page])
    @major_category_names = Genre.major_categories
    @genre = Genre.request_genre(genre_params)
    @genres = Genre.all
    @user = current_user
  end

  def show
    @user = current_user
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
      redirect_to products_path, notice: "投稿に成功しました"
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
      @product = current_user.products.find_by(id: params[:id])
      redirect_to(products_url, alert: "ERROR!!") if @product.blank?
    end
    
    def product_params
      params.require(:product).permit( :name, :description, :price, :category_id, :taste_id, :recommend, :user_id, :company, :genre_id, images: [])
    end
    
    def genre_params
      params[:genre].present? ?params[:genre]
                              : "none"
    end
end
