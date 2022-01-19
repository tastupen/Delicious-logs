FactoryBot.define do
  factory :product do
    name { "ぽてち" }
    description { "美味しい" }
    price {"100"}
    recommend {"5"}
    company {"カルビー"}
    instagram {"true"}
    taste
    category
    genre
    user
  end
end