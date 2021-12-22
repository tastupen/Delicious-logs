class Genre < ApplicationRecord
  has_many :products
  
  def self.major_categories
    pluck(:major_category_name).uniq
  end
  
  scope :request_genre, -> (genre) {
    if genre != "none"
      find(genre.to_i)
    else
      ""
    end
  }
end
