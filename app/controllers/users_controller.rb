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

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :phone, :token)
  end
end
