class SetDeliveryVehicle < ApplicationService
  def initialize(delivery, vehicle, delivery_params)
    @delivery = delivery
    @vehicle = vehicle
    @delivery_params = delivery_params
  end

  def call
    @delivery.vehicle = @vehicle
    @delivery.update(@delivery_params)
  end
end
