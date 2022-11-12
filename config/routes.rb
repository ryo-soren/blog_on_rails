Rails.application.routes.draw do
  root "posts#index"

  resource :session, only:[:new, :create, :destroy]
  resources :users, except:[:destroy]

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end
