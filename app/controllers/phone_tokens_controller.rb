class PhoneTokensController < ApplicationController


  def create
     unless params[:phone] =~ User::CELLPHONE_RE
       render json: {status: 'error', message: "手机号格式不正确！"}
       return
     end

     if session[:token_created_at] and
       session[:token_created_at] + 60 > Time.now.to_i
       render json: {status: 'error', message: "您已经申请过验证码啦，请60s后再试哦！"}
       return
     end

     ChinaSMS.use :yunpian, password: ENV["sms_signup"]
     token = generate_phone_token
     PhoneToken.upsert params[:phone], token
     ChinaSMS.to params[:phone], "【大赛加油站】#{token}(注册验证码)，请在15分钟内完成注册。如非本人操作，请忽略。"
     session[:token_created_at] = Time.now.to_i
     render json: {status: 'ok'}
  end

   def generate_phone_token len = 6
     a = lambda { (0..9).to_a.sample }
     token = ""
     len.times { |t| token << a.call.to_s }
     token
   end

end
