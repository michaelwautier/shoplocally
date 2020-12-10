class RemoveProductFromCart < ApplicationService
  def initialize(cart_product)
    @cart_product = cart_product
  end

  def call
    if @cart_product.quantity == 1
      @cart_product.destroy
    else
      @cart_product.decrement(:quantity)
      @cart_product.save
    end
    @product = Product.find(@cart_product[:product_id])
    @product.stock += 1
    @product.save
  end
end
