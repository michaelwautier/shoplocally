class ShowCategories < ApplicationService
  def initialize(category)
    @category = category
  end

  def call
    @products = Product.where(category: @category)
    @shops = []
    @products.each do |product|
      @shops << product.shop
    end
    @shops = @shops.uniq
    return [@category, @shops, @products]
  end
end
