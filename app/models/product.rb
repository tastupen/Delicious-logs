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
      "★★★★☆" => 4,
      "★★★☆☆" => 3, 
      "★★☆☆☆" => 2, 
      "★☆☆☆☆" => 1
    }
  }
  
  PER = 16
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
  
  
  scope :search_for_id_and_name, -> (keyword) {
    where("name LIKE ?", "%#{keyword}%").or(where("id LIKE ?", "%#{keyword}%"))
  }
  
  #csv
  def self.import_csv(file)
    new_products = []
    update_products = []
    
    CSV.foreach(file.path, headers: true, encoding: "Shift_JIS:UTF-8") do |row|
      row_to_hash = row.to_hash
      byebug
      if row_to_hash[:id].present?
        update_product = find(id: row_to_hash[:id])
        update_product.attributes = row.to_hash.slice!(csv_attributes)
        update_products << update_product
      else
        new_product = new
        new_product.attributes = row.to_hash.slice!(csv_attributes)
        new_products << new_product
      end
    end
    if update_products.present?
      import update_products, on_duplicate_key_update: csv_attributes
    elsif new_products.present?
      import new_products
    end
  end
  
  private
    def self.csv_attributes
      [:name, :description, :price, :category_id, :taste_id, :recommend, :instagram, :user_id, :company, :genre_id]
    end
  
end
