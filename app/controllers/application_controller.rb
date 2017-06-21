class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :authenticate_user!

  def authenticate_user!
    unless logged_in?
      flash[:notice] = "请登录~"
      redirect_to new_session_path
    end
  end
end
