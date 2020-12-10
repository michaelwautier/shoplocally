class AssignDelivery < ApplicationService
  def initialize(delivery)
    @delivery = delivery
  end

  def call
    @delivery.user = current_user
    @delivery.status = 'assigned'
    @delivery.save
  end
end
