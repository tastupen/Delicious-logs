class ReviewsController < ApplicationController
  def create
    @review= Review.create!(review_params)
  end
  
  private
    def review_params
      params.require(:review).permit(:content, :score).merge(user_id: current_user.id, product_id: params[:product_id])
    end
end
