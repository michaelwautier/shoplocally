class DeliveriesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:lat].present? && current_user.roles.include?(User::ROLES[0])
      @deliveries = @deliveries.near([params[:lat], params[:lng]], 75).where(status: 'pending_delivery_pickup')
    else
      current_user.roles.include?(User::ROLES[0])
      @deliveries = Delivery.order(:id).where(status: 'pending_delivery_pickup')
    end
    @my_deliveries = Delivery.order(:id).where('user_id = ? AND status != ?', current_user.id, 'delivered')
    # where(vehicle_id: current_user.vehicle_id).
  end

  def show
    @delivery = Delivery.find(params[:id])
  end

  def edit
    @delivery = Delivery.find(params[:id])
    @vehicles = Vehicle.all
  end

  def update
    @delivery = Delivery.find(params[:id])
    @vehicle = Vehicle.find_by(type_name: params[:delivery][:vehicle])
    @delivery.vehicle = @vehicle
    @delivery.update(delivery_params)
    redirect_to owner_path(current_user)
  end

  def show_for_delivery_guy
    @delivery = Delivery.find(params[:id])
  end

  def assign
    delivery = Delivery.find(params[:id])
    delivery.user = current_user
    delivery.status = 'assigned'
    delivery.save
    redirect_to deliveries_path
  end

  def update_status
    delivery = Delivery.find(params[:id])
    delivery.update(status: params[:delivery][:status])

    redirect_to deliveries_path
  end

  private

  def delivery_params
    params.require(:delivery).permit(:status)
  end
end
