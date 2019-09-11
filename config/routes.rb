Rails.application.routes.draw do

# config/initializers/...config.scoped_views = true　
# falseになっていると画面レイアウトができないので注意
  devise_for :users
  devise_for :owners
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# Topページ
root "root#top"



  # ユーザー
  resources :users

  # 予約
  resources :reservations

  # 飲食店（空きスペース）
  resources :restaurants do
      # レビュー機能
    resources :reviews
    get 'reservation_form' => 'reservations#new',as: 'reservations_form'
  end
  # オーナー
  resources :owners

  # いいね機能（いらないかも）
  resources :likes




end
