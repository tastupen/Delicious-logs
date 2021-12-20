class Product < ApplicationRecord
  belongs_to :category
  belongs_to :taste
  belongs_to :genre
  belongs_to :user
  
  has_many_attached :images
  
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
  
end
