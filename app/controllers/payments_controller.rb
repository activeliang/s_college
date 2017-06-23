class PaymentsController < ApplicationController

  protect_from_forgery except: [:pay_notify]
  # before_action :auth_request, only: [:pay_notify]
  before_action :authenticate_user!, except: [:pay_notify]

  def index
    # 对付款用户身份的检验
    if current_user.is_vip && current_user.expriy_date > Time.now
      redirect_to :back, notice: "您已经是会员了哦~"
    end

    @vip_price = VipPrice.where(:is_hidden => false).order(weight: 'desc').first
  end

  def generate_payment
    order = current_user.orders.find_by_token(params[:order_token])
    unless order.present? || order.is_paid
      redirect_to :back, warning: "找不到该订单或该订单已支付，请重检查！"
    end

    payment = Payment.new
    payment.user_id = current_user.id
    payment.price = order.price
    payment.save

    if payment.save
      order.payment_id = payment.id
      order.save
    end

    redirect_to create_payment_payments_path(payment_no: payment.payment_no, id: payment.id)

  end

  def create_payment
    payment = current_user.payments.find_by(payment_no: params[:payment_no])

    if payment.present? && !payment.is_paid

      pay_options = {
        "service" => 'create_direct_pay_by_user',
        "partner" => ENV["alipay_pid"],
        "seller_id" => ENV["alipay_pid"],
        "payment_type" => "1",
        "pay_type" => "1",
        "notify_url" => ENV["alipay_notify_url"],
        "return_url" => "",

        "anti_phishing_key" => "",
        "exter_invoke_ip" => "",
        "out_trade_no" => payment.payment_no,
        "subject" => "S商学院VIP会员",
        "total_fee" => payment.price,
        "body" => "S商学院VIP会员",
        "_input_charset" => "utf-8",
        "sign_type" => 'MD5',
        "sign" => "",
        "page" => "3"
      }
      pay_options.merge!("sign" => build_generate_sign(pay_options))


      body = RestClient.get ENV["alipay_url"] + "?" + pay_options.to_query

      pay_qr = JSON.parse(body)["qr"]
      order_id = JSON.parse(body)["order_id"]
      @qr = RQRCode::QRCode.new(pay_qr, :size => 6, :level => :h )


      render :json => { :test7 => '<%= rucaptcha_image_tag %>', :qrcode => @qr.as_html, :order_id => order_id, :status => "ok", payment_no: payment.payment_no, price: payment.price }

    else
      render :json => { :status => "支付号已支付或不存在，请重新生成支付" }

    end
  end

  def pay_return
    do_payment_test
  end

  def pay_notify
    do_payment_test
  end

  def test
    body2 = RestClient.get ENV["alipay_is_paid_url"] + {
      id: ENV["alipay_pid"],
      order_id: params[:order],
      token: ENV["require_token"],
      call: ""
    }.to_query
    order_status = JSON.parse(body2)["status"]

    render :json => { :liang => order_status }
  end

  def success

  end

  def failed

  end

  private
  def is_payment_success?
    !params[:trade_no].nil?
  end

  def update_status
    @payment = Payment.find_by_payment_no(params[:out_trade_no])
    redirect_to root_path
  end

  def do_payment_test

    @payment = Payment.find_by_payment_no(params[:out_trade_no])
    unless @payment.is_success?
      if is_payment_success?
        ChinaSMS.use :yunpian, password: ENV["sms_pay"]
        ChinaSMS.to @payment.user.phone, "待继。。。"

        @payment.do_success_payment! params
        render :json => "ok"
      else
        @payment.do_failed_payment! params
      end
    end
  end

  def auth_request
    option = params.to_hash
    if option["code"] != ENV["alipay_code_key"]
      redirect_to failed_payments_path
    end
  end

  def build_generate_sign options
    sign_data = build_sign_data(options.dup)
    Digest::MD5.hexdigest(sign_data + ENV["alipay_md5_secret"])
  end


  def build_sign_data data_hash
    data_hash.delete_if { |k, v| k == "sign_type" || k == "sign" || v.blank? }
    data_hash.to_a.map { |x| x.join('=') }.sort.join('&')
  end

end
