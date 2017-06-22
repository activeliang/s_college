class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to new_session_path, notice: "注册成功，请登入~"
      else

        render action: :new
      end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit_detail
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "您已修改成功~"
    else
      redirect_to :back, warning: "修改出错，请重试！"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :phone, :token, :wechat, :user_image, :email, :user_name, :contact_phone)
  end
end
