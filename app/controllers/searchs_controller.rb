class SearchsController < ApplicationController
  def search
    @keyword = params[:keyword]
    @price = params[:price]
    @products = []
    @keywords = @keyword.split(/[[:blank:]]+/)
    if @keyword and @price.present?
      @keywords.each do |keyword|
        @products += Product.joins(:genre).where(["products.name like ? OR genres.name like ? OR company like ? OR major_category_name like ?", "#{keyword}%", "#{keyword}%", "#{keyword}%", "#{keyword}%" ]).where("price <= ?", @price)
        @pages = Kaminari.paginate_array(@products).page(params[:page]).per(5)
      end
    else
      @keywords.each do |keyword|
        @products += Product.joins(:genre).where(["products.name like ? OR genres.name like ? OR company like ? OR major_category_name like ?", "#{keyword}%", "#{keyword}%", "#{keyword}%", "#{keyword}%" ])
        @pages = Kaminari.paginate_array(@products).page(params[:page]).per(5)
      end
    end
    render "search"
  end
end
