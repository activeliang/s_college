Rails.application.routes.draw do
  # 首页导向：
  root 'welcome#index'

  # 测试用的页面
  get 'test' => 'welcome#test'

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
    resources :vip_prices do
      member do
        post :update_state
        post :update_weight
      end
    end
    resources :users
  end

  # 用户浏览课程的路由
  resources :posts
  resources :lessons do
    member do
      get :syllabus
    end
    resources :chapters
  end

  # 创建订单的路由
  resources :orders

  # 用户信息编辑
  resources :users do
    member do
      post :edit_detail
    end
  end




end
