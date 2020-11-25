class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_cart, only: %i[show checkout checkout_confirmation]

  def show; end

  def create; end

  def checkout
    @address = Address.new
  end

  def checkout_confirmation
    case params["address-selection"]
    when 'user'
      @address = current_user.address
      create_order(@address)
    when 'pickup' then create_order(nil)
    when 'new'
      @address = Address.new(checkout_address_params)
      if @address.save
        create_order(@address)
      else
        flash.now[:alert] = 'Please provide a shipping address'
        render :checkout
      end
    end
  end

  def current_cart
    if current_user.carts.find_by(current_cart: true)
      @cart = current_user.carts.find_by(current_cart: true)
    else
      @cart = Cart.new
      @cart.user = current_user
      @cart.save
    end
    @cart
  end

  private

  def checkout_address_params
    params.require(:address).permit(:street, :number, :postcode, :city)
  end

  def create_order(shipping_address)
    cart = current_cart
    order = Order.new(address: shipping_address, cart: cart, user: current_user)
    order.status = 'Waiting for payment'
    if order.save
      cart.update(current_cart: false)
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['bancontact', 'card'],
        line_items: stripe_line_items(order),
        success_url: order_url(order),
        cancel_url: order_url(order)
      )
      order.update(checkout_session_id: session.id)
      redirect_to order_path order
    else
      @address = Address.new
      flash.now[:alert] = 'Oops something went wrong order not created!'
      render :checkout
    end
  end

  def stripe_line_items(order)
    lines = []
    order.cart.cart_products.each do |line|
      lines << { name: line.product.name, amount: line.product.price_cents, currency: 'eur', quantity: line.quantity }
    end
    return lines
  end

  # create a delivery for each shop from the order
  # def order_to_deliveries(order)
  #   shops = order.cart.cart_products.map { |line| line.product.shop }
  #   shops.uniq.each do |shop|
  #     deli = Delivery.new(order: order, shop: shop, status: 'Waiting for payment')
  #     deli.save!
  #   end
  # end
end
