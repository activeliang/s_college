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

  # admin的命名空间
  namespace :admin do
    resources :categories
    resources :lessons do
      resources :chapters
      resources :posts do
        member do
          post :update_weight
        end
      end
    end
  end

end
