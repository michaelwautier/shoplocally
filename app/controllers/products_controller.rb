class ProductsController < ApplicationController
  def index
    @products = Product.where(shop_id: params[:shop_id])
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @shop = Shop.find(params[:shop_id])
    @product = Product.new
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @category = Category.find(params[:product][:category])
    @product = Product.new(product_params)
    @product.shop = @shop
    @product.category = @category
    if @product.save
      redirect_to shop_products_path(@shop)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @category = Category.find(params[:product][:category])
    @product.category = @category
    @product.update(product_params)
    redirect_to shop_product_path(@product.shop, @product)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to shop_products_path(@product.shop)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :ean, :tax)
  end
end
