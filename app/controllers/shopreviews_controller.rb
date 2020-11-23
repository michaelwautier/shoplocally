class ShopreviewsController < ApplicationController

  def new
    @shopreview = Shopreview.new
    @shop = Shop.find(params[:shop_id])
  end

  def create
    @shopreview = Shopreview.new(shopreview_params)
    @shopreview.user = current_user
    @shop = Shop.find(params[:shop_id])
    @shopreview.shop = @shop
    if @shopreview.save
      redirect_to shop_path(@shop)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def shopreview_params
    params.require(:shopreview).permit(:content, :rating)
  end
end
