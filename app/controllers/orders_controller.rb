class OrdersController < ApplicationController
  before_action :authenticate_user!
  def show

  end


  def create_order
    if current_user.is_vip && current_user.expriy_date > Time.now
      redirect_to :back, notice: "您已经是会员了哦~"
    end

    vip_price = VipPrice.where(:is_hidden => false).order( weight: 'desc').first.price

    order = Order.new
    order.price = vip_price
    order.user_id = current_user.id
    order.save

    redirect_to generate_payment_payments_path(order_token: order.token)
  end
end
