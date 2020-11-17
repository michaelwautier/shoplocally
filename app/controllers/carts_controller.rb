class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
  end

  def create
  end

  def current_cart
    if current_user.carts.find_by(current_cart: true)
      cart = current_user.carts.find_by(current_cart: true)
    else
      cart = Cart.new
      cart.user = current_user
      cart.save
    end
    return cart
  end
end
