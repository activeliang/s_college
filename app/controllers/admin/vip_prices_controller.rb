class Admin::VipPricesController < ApplicationController

  before_action :find_vip_price, only:[:destroy, :edit, :update, :update_state, :update_weight]

  layout 'admin'


  def index
    @vip_prices = VipPrice.all
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
      redirect_to admin_vip_prices_path, notice: "success!"
    else
      redirect_to :back, alert: "failed!"
    end
  end



  def update_state
    if @vip_price.is_hidden
      @vip_price.update_column :is_hidden, false
      flash[:warning] = "已下架"
    else
      @vip_price.update_column :is_hidden, true
      flash[:notice] = "已上架"
    end
    redirect_to :back
  end

  def update_weight
    if @vip_price.update_column :weight, params[:weight]
      redirect_to :back, notice: "success!"
    else
      redirect_to :back, warning: "failed!"
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
