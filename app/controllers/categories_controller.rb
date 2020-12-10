class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def show
    array = ShowCategories.call(Category.find(params[:id]))
    @category = array[0]
    @shops = array[1]
    @products = array[2]
  end
end
