class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def show
    @category = Category.find(params[:id])
    @products = Product.where(category: @category)
    @shops = Shop.all
    @category_shops = @shops.select do |shop|
      @products.ids.include?(shop.products.ids)
    end
    # @category_shops = @products.each do |product|
    #   @products.select(:shop).distinct
    # end
  end
end
