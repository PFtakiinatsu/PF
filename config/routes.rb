Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations',
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/about" => "homes#about"
  root to: "homes#top"
  resources :questions do
    #7つの基本アクション以外を定義するときにはcollectionかmemberを使う
    collection do
      get "search"
    end
    resources :comments, only: [:create, :destroy]
    #resourceで単数形にすると/:idなしになる=>createとdestroyが同じrootパスになる
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]

end
