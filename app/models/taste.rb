class Taste < ApplicationRecord
  has_many :products
  
  def self.search(keyword)
    where(["taste_intensity like?", "%#{keyword}%" ])
  end
end
