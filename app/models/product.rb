class Product < ApplicationRecord
  belongs_to :category
  belongs_to :taste
  belongs_to :genre
  belongs_to :user
  
  has_many_attached :images
  
  has_many :reviews
  
  def reviews_new
    reviews.new
  end
  
  def reviews_with_id
    reviews.reviews_with_id
  end
  
  has_many :likes
  
  scope :star_repeat_select, -> { 
    {
      "★★★★★" => 5, 
      "★★★★" => 4,
      "★★★" => 3, 
      "★★" => 2, 
      "★" => 1
    }
  }
  
  PER = 12
  scope :display_list, -> (page) { page(page).per(PER) }
  scope :on_genre, -> (genre) { where(genre_id: genre) }
  scope :sort_order, -> (order) { order(order) }
  
  scope :genre_products, -> (genre, page) {
    on_genre(genre).display_list(page)
  }
  scope :sort_products, -> (sort_order, page) {
    on_genre(sort_order[:sort_genre]).sort_order(sort_order[:sort]).display_list(page)
  }
  
  scope :sort_list, -> {
    {
      "並び替え" => "", 
      "価格の安い順" => "price asc",
      "価格の高い順" => "price desc",
      "出品の古い順" => "updated_at asc", 
      "出品の新しい順" => "updated_at desc",
    }
  }
  
  scope :recently_products, -> (number) { order(created_at: "desc").take(number) }
  scope :instagram_products, -> (number) { where(instagram: true).take(number) }
end
