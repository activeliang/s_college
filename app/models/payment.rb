class Payment < ApplicationRecord
  before_create :gen_payment_no

  has_many :orders
  belongs_to :user

  def do_success_payment! params
    self.transaction do
      self.transaction_no = params[:pay_no]
      self.is_paid = true
      self.raw_response = params.to_json
      self.payment_at = Time.now
      self.save!

      self.orders.each do |order|
        if order.is_paid?
          raise "order #{order.order_no} has alreay been paid"
        end

        order.is_paid = true
        order.payment_at = Time.now
        order.save

        user = User.find(order.user_id)
        user.is_vip = true
        user.expriy_date = Date.tody + 365
        user.save

      end
    end
  end

  def do_failed_payment! params
    self.transaction_no = params[:trade_no]
    self.is_paid = true
    self.raw_response = params.to_json
    self.payment_at = Time.now
    self.save!
  end


  private

  def gen_payment_no
    self.payment_no = generate_utoken(32)
  end

  def generate_utoken len = 8
    a = lambda { rand(36).to_s(36) }
    token = ""
    len.times { |t| token << a.call.to_s }
    token
  end
end
