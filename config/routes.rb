Rails.application.routes.draw do
  # 首页导向：
  root 'welcome#index'

  # 登陆的路径：
  resources :sessions
  # 注册的路径：
  resources :users
  # 登出的路径：
  delete '/logout' => 'sessions#destroy', as: :logout
  # 生成验证码并验证的路径：
  resources :phone_tokens, only: [:create]


end
