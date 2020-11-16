class ShopsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  skip_after_action :verify_authorized, only: %i[show new]

  def index
    @shops = policy_scope(Shop).all
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
    authorize @shop
    if @shop.save
      redirect_to shop_path(@shop)
    else
      render :new
    end
  end

  def edit
    @shop = Shop.find(params[:id])
    authorize @shop
  end

  def update
    @shop = Shop.find(params[:id])
    authorize @shop
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
