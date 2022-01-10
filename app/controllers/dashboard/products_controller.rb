class Dashboard::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: %w[show edit update destroy]
  layout "dashboard/dashboard"
  
  def index
    @sorted = ""
    @sort_list = Product.sort_list
    
    if params[:sort].present?
      @sorted = params[:sort]
    end
    
    if params[:keyword].present?
      keyword = params[:keyword].strip
      @total_count = Product.search_for_id_and_name(keyword).count
      @products = Product.search_for_id_and_name(keyword).display_list(params[:pages])
    else
      @total_count = Product.count
      @products = Product.sort_order(@sorted).display_list(params[:page])
    end
  end
  
  def destroy
    @product.destroy
    redirect_to dashboard_products_path
  end
  
  #csv
  def import
  end
  
  def import_csv
    if params[:file] && File.extname(params[:file].original_filename) == ".csv"
      Product.import_csv(params[:file])
      flash[:success] = "CSVでの一括登録が成功しました!"
      redirect_to import_csv_dashboard_products_url
    else
      flash[:danger] = "CSVが追加されていません。CSVを追加してください。"
      redirect_to import_csv_dashboard_products_url
    end
  end
  
  def download_csv
    send_file(
      "#{Rails.root}/public/csv/products.csv",
      filename: "products.csv",
      type: :csv
    )
  end
  
  private
    def set_product
      @product = Product.find(params[:id])
    end
  
end
