class ShopsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @shops = params[:lat].present? ? Shop.near([params[:lat], params[:lng]], 70) : Shop.all
    @markers = @shops.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { shop: shop })
      }
    end
  end

  def new
    @address = Address.new
    @shop = Shop.new
  end

  def show
    @shop = Shop.find(params[:id])
    @shopreview = Shopreview.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user
    @shop.address = Address.create(
      street: params[:street],
      number: params[:number],
      postcode: params[:postcode],
      city: params[:city]
    )
    current_user.add_role("owner")
    if @shop.save
      redirect_to shop_path(@shop)
    else
      render :new
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.address.update(
      street: params[:street],
      number: params[:number],
      postcode: params[:postcode],
      city: params[:city]
    )
    @shop.update(shop_params)
    redirect_to shop_path(@shop)
  end

  def owner
    if current_user.shops.empty?
      redirect_to new_shop_path
    else
      @deliveries = Delivery.order(id: :desc).select do |delivery|
        current_user.shops.ids.include?(delivery.shop_id)
      end
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description, :vat_number, :address, :logo, :longitude, :latitude, pictures: [])
  end
end
