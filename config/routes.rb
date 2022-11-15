Rails.application.routes.draw do
  root "posts#index"

  resource :session, only:[:new, :create, :destroy]
  resources :users, except:[:destroy] do
      get "edit_password"
      patch "edit_password", to: "users#update_password"
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end
