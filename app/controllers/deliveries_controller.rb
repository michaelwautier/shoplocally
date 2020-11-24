class DeliveriesController < ApplicationController
  # GET   /orders/:order_id/deliveries/:id  deliveries#show
  def show
    @delivery = Delivery.find(params[:id])
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    @delivery.update(delivery_params)
    redirect_to owner_path(current_user)
  end

  private

  def delivery_params
    params.require(:delivery).permit(:status)
  end
end
