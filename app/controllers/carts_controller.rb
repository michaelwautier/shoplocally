class CartsController < ApplicationController

  def show
    @cart = Cart.find()
  end

  def create

  end
end
