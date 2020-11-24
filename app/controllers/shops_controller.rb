class ShopsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    if params[:query].present?
      sql_query = "name ILIKE :query"
      @shops = Shop.where(sql_query, query: "%#{params[:query]}%")
      @products = Product.where(sql_query, query: "%#{params[:query]}%")
    else
      @shops = params[:lat].present? ? Shop.near([params[:lat], params[:lng]], 70) : Shop.all
    end
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
    @deliveries = Delivery.select do |delivery|
      current_user.shops.ids.include?(delivery.shop_id)
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description, :vat_number, :address, :logo, :longitude, :latitude, pictures: [])
  end
end
