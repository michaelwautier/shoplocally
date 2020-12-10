class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[show edit update destroy add_to_cart]
  def index
    @shop = Shop.find(params[:shop_id])
    @products = Product.where(shop_id: params[:shop_id])
  end

  def show
    @productreview = Productreview.new
  end

  def new
    @shop = Shop.find(params[:shop_id])
    @product = Product.new
  end

  def create
    @shop = Shop.find(params[:shop_id])
    if params[:product][:file]
      Product.import(params[:product][:file], @shop)
      flash[:notice] = "Products uploaded successfully"
      redirect_to shop_products_path(@shop)
    else
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
  end

  def edit; end

  def update
    UpdateProduct.call(@product, product_params, params[:product][:category])
    redirect_to shop_product_path(@product.shop, @product)
  end

  def destroy
    @product.destroy
    redirect_to shop_products_path(@product.shop)
  end

  def add_to_cart
    if AddProductToCart.call(@product, current_user) == 'success'
      redirect_to current_cart_path, notice: 'Product added to cart!'
    else
      redirect_to current_cart_path, notice: 'Product out of stock!'
    end
  end

  def remove_from_cart
    RemoveProductFromCart.call(CartProduct.find(params[:id]))
    redirect_to current_cart_path, notice: 'Product removed from cart!'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :ean, :tax, photos: [])
  end
end
