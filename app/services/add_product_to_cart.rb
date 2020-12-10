class AddProductToCart < ApplicationService
  def initialize(product, current_user)
    @product = product
    @current_user = current_user
  end

  def call
    if @product.stock.positive?
      cart = current_cart
      @product.stock -= 1
      @product.save
      if cart_product = cart.cart_products.find_by(product_id: @product.id)
        cart_product.increment(:quantity)
      else
        cart_product = CartProduct.new(product_id: @product.id, product_price: @product.price, product_tax: @product.tax, quantity: 1)
      end
      cart_product.cart = cart
      cart_product.save
      return 'success'
    else
      return 'fail'
    end
  end

  private

  def current_cart
    if @current_user.carts.find_by(current_cart: true)
      cart = @current_user.carts.find_by(current_cart: true)
    else
      cart = Cart.new
      cart.user = @current_user
      cart.save
    end
    return cart
  end
end