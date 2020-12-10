class ShowDeliveries < ApplicationService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    if @params[:lat].present? && @current_user.roles.include?(User::ROLES[0])
      return Delivery.near([@params[:lat], @params[:lng]], 75).where(status: 'pending_delivery_pickup')
    elsif @current_user.roles&.include?(User::ROLES[0])
      return Delivery.order(:id).where(status: 'pending_delivery_pickup')
    end

    nil
  end
end
