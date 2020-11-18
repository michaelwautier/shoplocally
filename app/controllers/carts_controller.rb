class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_cart, only: %i[show checkout checkout_confirmation]

  def show; end

  def create; end

  def checkout
    @address = Address.new
  end

  def checkout_confirmation
    
  end

  def current_cart
    if current_user.carts.find_by(current_cart: true)
      @cart = current_user.carts.find_by(current_cart: true)
    else
      @cart = Cart.new
      cart.user = current_user
      cart.save
    end
    @cart
  end
end
