class DeliveriesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin
      @deliveries = Delivery.all
    elsif params[:lat].present? && current_user.roles.include?(User::ROLES[0])
      @deliveries = @deliveries.near([params[:lat], params[:lng]], 25).where(status: 'pending')
    elsif current_user.roles.include?(User::ROLES[0])
      @deliveries = Delivery.where(vehicle_id: current_user.vehicle_id).where(status: 'pending')
    end
    @my_deliveries = Delivery.where('user_id = ? AND status != ?', current_user.id, 'delivered')
  end

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
  
  def show_for_delivery_guy
    @delivery = Delivery.find(params[:id])
  end

  private

  def delivery_params
    params.require(:delivery).permit(:status)
  end
end
