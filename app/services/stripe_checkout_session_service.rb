class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(status: 'paid')
    order_to_deliveries(order)
  end

  def order_to_deliveries(order)
    shops = order.cart.cart_products.map { |line| line.product.shop }
    shops.uniq.each do |shop|
      deli = Delivery.new(order: order, shop: shop, status: 'pending')
      deli.save!
    end
  end
end
