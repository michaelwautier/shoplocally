class ProductreviewsController < ApplicationController

    def new
    @productreview = Productreview.new
    @product = Product.find(params[:product_id])
  end

  def create
    @productreview = Productreview.new(productreview_params)
    @productreview.user = current_user
    @product = Product.find(params[:product_id])
    @productreview.product = @product
    if @productreview.save
      redirect_to shop_product_path(@product.shop, @product)
    else
      flash[:alert] = "Something went wrong."
      render 'products/show'
    end
  end

  private

  def productreview_params
    params.require(:productreview).permit(:content, :rating)
  end
end
