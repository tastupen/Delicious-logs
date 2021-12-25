class SearchsController < ApplicationController
  def search
    @products = Product.search(params[:keyword])
    render "search"
  end
end
