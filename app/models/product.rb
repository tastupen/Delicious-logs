class Product < ApplicationRecord
  belongs_to :category
  belongs_to :taste
  belongs_to :user
  
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
