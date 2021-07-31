# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: 'users/registrations'
             }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/about' => 'homes#about'
  root to: 'homes#top'
  resources :questions do
    # 7つの基本アクション以外を定義するときにはcollectionかmemberを使う
    collection do
      get 'search'
    end
    resources :comments, only: %i[create destroy]
    # resourceで単数形にすると/:idなしになる=>createとdestroyが同じrootパスになる
    resource :bookmarks, only: %i[create destroy]
  end
  resources :users, only: %i[show edit update index]
end
