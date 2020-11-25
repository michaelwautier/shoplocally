class PagesController < ApplicationController
  before_action :authenticate_user!, except: %i[home]
  def home; end

  def search
    sql_query = "name ILIKE :query"
    @shops_name = Shop.where(sql_query, query: "%#{params[:query]}%")
    @products = Product.where(sql_query, query: "%#{params[:query]}%")
    @shops = []
    @products.each do |product|
      @shops << product.shop
    end
    @shops = @shops.uniq
  end
end
