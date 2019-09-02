Rails.application.routes.draw do
  devise_for :owners
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Topページ
  get "top" => "root#top"

  # ユーザー
  resources :users

  # 予約
  resources :reservations

  # 飲食店（空きスペース）
  resources :restaurants

  # オーナー
  resources :owners

  # いいね機能
  resources :likes

  # レビュー機能
  resources :reviews


end
