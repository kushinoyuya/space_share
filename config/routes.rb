Rails.application.routes.draw do

# config/initializers/...config.scoped_views = true　
# falseになっていると画面レイアウトができないので注意
  devise_for :users, controllers: {
    sessions:       'users/sessions',
    passwords:      'users/passwords',
    registrations:  'users/registrations'
  }

  devise_for :owners, controllers: {
    sessions:       'owners/sessions',
    passwords:      'owners/passwords',
    registrations:  'owners/registrations'
  }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Topページ
root "root#top"
  # ユーザー
  resources :users
  # 予約
  resources :reservations do
    collection do
      post 'pay'
    end
  end
  # 飲食店（空きスペース）
  resources :restaurants do
    resources :reviews
    get 'reservation_form' => 'reservations#new',as: 'reservations_form'
  end
  # オーナー
  resources :owners




end
