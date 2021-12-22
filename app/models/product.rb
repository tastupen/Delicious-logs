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
  
  PER = 6
  
  scope :display_list, -> (genre, page) {
    if genre != "none"
      where(genre_id: genre).page(page).per(PER)
    else
      page(page).per(PER)
    end
  }
  
end
