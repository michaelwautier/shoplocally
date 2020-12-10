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
  product.update(price_cents: product.price_in_cents )
  puts ("price_in_cents = #{product.price_in_cents} | price_cents = #{product.price_cents}")
end

User.all.each do |user|
  address = Address.create(street: 'Rue Laurent Delvaux', number: user.id, postcode: '1400', city: 'Nivelles')
  shop = Shop.create(
    name: "Shop of user #{user.id}",
    description: "Description of shop user #{user.id}",
    address_id: address.id,
    user_id: user.id,
    vat_number: "BE1234567890"
  )
  product = Product.create(
    name: "Product of shop ##{shop.id}",
    description: "Product 1 - Test description for test product",
    price_cents: 2000,
    ean: "123456789",
    stock: 3,
    tax: 21,
    shop_id: shop.id,
    category_id: 1
  )
end
