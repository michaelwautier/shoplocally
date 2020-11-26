class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user)
  end

  def show
    @order = Order.find(params[:id])
  end

  def fake_payment
    order = Order.find(params[:id])
    order.update(status: 'paid')
    sc = StripeCheckoutSessionService.new
    sc.order_to_deliveries(order)
    redirect_to order_path order
  end
end
