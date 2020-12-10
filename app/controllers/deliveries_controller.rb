class DeliveriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_delivery, except: %i[index]

  def index
    @deliveries = ShowDeliveries.call(params, current_user)
    @my_deliveries = Delivery.order(:id).where('user_id = ? AND status != ?', current_user.id, 'delivered')
    # where(vehicle_id: current_user.vehicle_id).
  end

  def show; end

  def edit
    @vehicles = Vehicle.all
  end

  def update
    SetDeliveryVehicle.call(@delivery, Vehicle.find_by(type_name: params[:delivery][:vehicle]), delivery_params)
    redirect_to owner_path(current_user)
  end

  def show_for_delivery_guy
  end

  def assign
    AssignDelivery.call(@delivery)
    redirect_to deliveries_path
  end

  def update_status
    @delivery.update(status: params[:delivery][:status])
    redirect_to deliveries_path
  end

  private

  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

  def delivery_params
    params.require(:delivery).permit(:status)
  end
end
