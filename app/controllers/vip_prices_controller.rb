class VipPricesController < ApplicationController

  before_action :find_vip_price, only:[:destroy]

  def new
    @vip_price = VipPrice.new
  end

  def create
    @vip_price = VipPrice.new(vip_price_params)
    if @vip_price.save
      redirect_to :back, notice: "success!"
    else
      redirect_to :back, alert: "failed!"
    end
  end

  def destroy
    if @vip_price.destroy
      redirect_to :back, warning: "Deleted!"
    end
  end

  def edit

  end

  def update
    if @vip_price.update(vip_price_params)
      redirect_to :admin_vip_prices_path, notice: "success!"
    else
      redirect_to :back, alert: "failed!"
    end
  end

  private

  def find_vip_price
    @vip_price = VipPrice.find(params[:id])
  end

  def vip_price_params
    params.require(:vip_price).permit(:title, :price, :weight, :is_hidden)
  end
end
