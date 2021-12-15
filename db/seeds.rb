# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

type_of_tastes = ["甘い", "普通", "辛い"]

type_of_tastes.each do |type_of_taste|
  Category.create(
    type_of_taste: type_of_taste
    )
end