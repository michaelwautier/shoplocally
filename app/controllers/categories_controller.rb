class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def show
    @category = Category.find(params[:id])
    @products = Product.where(category: @category)
    @shops = []
    @products.each do |product|
      @shops << product.shop
    end
    @shops = @shops.uniq
  end
end
