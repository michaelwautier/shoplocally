class UpdateProduct < ApplicationService
  def initialize(product, product_params, category_params)
    @product = product
    @product_params = product_params
    @category = Category.find(category_params)
  end

  def call
    @product.category = @category
    @product.update(@product_params)
  end
end
