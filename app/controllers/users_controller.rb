class UsersController < ApplicationController
  before_action :set_user
  
  def edit
  end

  def update
    @user.update_without_password(user_params)#deviseで使えるメソッド！
    redirect_to mypage_users_url
  end

  def mypage
  end
  
  def edit_password
  end
  
  def update_password
    if password_set?
      @user.update_password(user_params) 
      flash[:notice] = "パスワードは正しく更新されました。"
      redirect_to root_url
    else
      @user.errors.add(:password, "パスワードに不備があります。")
      render "edit_password"
    end
  end
  
  def myposts
    @myposts = current_user.products.all.order(created_at: :desc)
    @categories = Category.all
    @tastes = Taste.all
    @genres = Genre.all
    @product_star_repeat_select = Product.star_repeat_select
    @likes = Like.where(user_id: current_user.id).order(created_at: :desc)
    @reviews = Review.select(:user_id, :product_id).distinct
  end
  
  def destroy
    @user.deleted_flg = User.switch_flg(@user.deleted_flg)
    @user.update(deleted_flg: @user.deleted_flg)
    redirect_to new_user_session_path
  end
  
  
  private
  
    def set_user
      @user = current_user
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
    
    def password_set?
      user_params[:password].present? && user_params[:password_confirmation].present? ?
      true : false
    end
end
