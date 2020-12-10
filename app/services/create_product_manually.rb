class CreateProductManually < ApplicationService
  def initialize(product_params, params, shop)
    @product_params = product_params
    @params = params
    @shop = shop
  end

  def call
    category = Category.find(@params[:product][:category])
    @product = Product.new(@product_params)
    @product.shop = @shop
    @product.category = category
    return @product unless @product.save
  end
end

# @shop = Shop.find(params[:shop_id])
# if params[:product][:file]
#   CreateProductWithCSV.call(params[:product][:file], @shop)
#   flash[:notice] = "Products uploaded successfully"
#   redirect_to shop_products_path(@shop)
# elsif @product = CreateProductManually.call(product_params, params, @shop)
#   redirect_to shop_products_path(@shop)
# else
#   render :new
# end
