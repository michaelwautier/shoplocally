class DeliveriesController < ApplicationController
  # GET   /orders/:order_id/deliveries/:id  deliveries#show
  def show
    @delivery = Delivery.find(params[:id])
  end
end
