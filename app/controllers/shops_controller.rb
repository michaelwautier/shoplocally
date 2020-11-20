class ShopsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    if params[:query].present?
      sql_query = "name ILIKE :query"
      @shops = Shop.where(sql_query, query: "%#{params[:query]}%")
      @products = Product.where(sql_query, query: "%#{params[:query]}%")
    else
      @shops = Shop.all
    #   # @addresse = Address.near([current_user.address.latidude, 4.4433408], 2)
    #   @addresse = Address.near([params[:lat], params[:lng]], 20)
    #   if @addresse.empty?
    #     @addresse = Address.near([params[:lat], params[:lng]], 100)
    #   end
    #   raise
    #   @shops = @shops.select { |shop| @addresse.include?(shop.address) }
    end
    @addresses = Address.all
    @markers = @shops.map do |shop|
      {
        lat: shop.address.latitude,
        lng: shop.address.longitude,
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
    params.require(:shop).permit(:name, :description, :vat_number, :address, :logo, pictures: [])
  end
end
