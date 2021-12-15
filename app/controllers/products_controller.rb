class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
    @categories = Category.all
    @tastes = Taste.all
    @product_star_repeat_select = Product.star_repeat_select
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to root_path, notice: "投稿に成功しました"
    else
      redirect_to new_product_path, alert: "投稿に失敗しました"
    end
  end

  def edit
    @categories = Category.all
    @tastes = Taste.all
  end

  def update
    if @product.update(goal_params)
      redirect_to product_url @product, notice: "投稿をアップデートしました"
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
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.require(:product).permit( :name, :description, :price, :category_id, :taste_id, :recommend, :user_id, :company)
    end
end