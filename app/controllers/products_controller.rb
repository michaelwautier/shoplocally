class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @shop = Shop.find(params[:shop_id])
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

  def add_to_cart
    @product = Product.find(params[:id])
    if @product.stock > 0
      cart = current_cart
      @product.stock -= 1
      @product.save
      if cart_product = cart.cart_products.find_by(product_id: @product.id)
        cart_product.increment(:quantity)
      else
        cart_product = CartProduct.new(product_id: @product.id, product_price: @product.price, product_tax: @product.tax, quantity: 1)
      end
      cart_product.cart = cart
      cart_product.save
      redirect_to current_cart_path, notice: 'Product added to cart!'
    else
      redirect_to current_cart_path, notice: 'Product out of stock!'
    end
  end

  def remove_from_cart
    cart_product = CartProduct.find(params[:id])
    if cart_product.quantity == 1
      cart_product.destroy
    else
      cart_product.decrement(:quantity)
      cart_product.save
    end
    @product = Product.find(cart_product[:product_id])
    @product.stock += 1
    @product.save
    redirect_to current_cart_path, notice: 'Product removed from cart!'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :ean, :tax, photos: [])
  end

  def current_cart
    if current_user.carts.find_by(current_cart: true)
      cart = current_user.carts.find_by(current_cart: true)
    else
      cart = Cart.new
      cart.user = current_user
      cart.save
    end
    return cart
  end
end
