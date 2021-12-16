class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :products
  
  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    
    result = update(params, *options)
    clean_up_passwords
    result
  end
  
  extend SwitchFlg
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
