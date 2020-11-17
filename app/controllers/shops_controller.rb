class ShopsController < ApplicationController
  def index
    @shops = Shop.all
    @addresses = Address.all
    @markers = @addresses.geocoded.map do |address|
      {
       lat: address.latitude,
       lng: address.longitude,
       infoWindow: render_to_string(partial: "info_window", locals: { address: address })
      }
    end
  end

  def new
    @address = Address.new
    @shop = Shop.new
  end

  def show
    @shop = Shop.find(params[:id])
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

  private

  def shop_params
    params.require(:shop).permit(:name, :description, :vat_number, :address)
  end
end
