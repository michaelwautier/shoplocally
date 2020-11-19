class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = Product.where(category: @category)
  end
end
