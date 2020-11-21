# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Vehicle.count == 0
  puts "Creating vehicles..."
  Vehicle::TYPES.each do |type|
    Vehicle.create(type_name: type)
  end
  puts "Vehicles created"
end

if Category.count == 0
  puts "Creating categories..."
  Category::CATEGORIES.each do |category|
    Category.create(name: category)
  end
  puts "Categories created"
end

# convert price (float) to price_in_cents (integer)
Product.all.each do |product|
  product.update(price_in_cents: (product.price * 100).to_i)
  puts ("price = #{product.price} | price_in_cents = #{product.price_in_cents}")
end