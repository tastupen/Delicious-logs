class SearchsController < ApplicationController
  def search
    @keyword = params[:keyword]
    @price = params[:price]
    @products = []
    @keywords = @keyword.split(/[[:blank:]]+/)
    if @keyword and @price.present?
      @keywords.each do |keyword|
        @products += Product.where(["name like ? OR company like ?", "#{keyword}%", "#{keyword}%"]).where(price: @price)
        @genres = Product.joins(:genre).where(["genres.name like ? OR genres.major_category_name like ?", "#{keyword}%", "#{keyword}%"]).where(price: @price)
      end
    elsif params[:price].present?
      @products += Product.where(price: Float::MIN..params[:price])
    else
      @keywords.each do |keyword|
        @products += Product.where(["name like ? OR company like ?", "#{keyword}%", "#{keyword}%"])
        @genres = Product.joins(:genre).where(["genres.name like ? OR genres.major_category_name like ?", "#{keyword}%", "#{keyword}%"])
      end
    end
    render "search"
  end
end
