class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :authenticate_user!

  def admin_required
    unless current_user.is_admin?
      redirect_to :root_path, warning: "您不是管理员哦~！"
    end
  end

  def authenticate_user!
    unless logged_in?
      flash[:notice] = "请登录~"
      redirect_to new_session_path
    end
  end
end
