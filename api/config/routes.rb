Rails.application.routes.draw do

  # root 'application#index'


    get 'login', to: "sessions#new"
  #  get 'sessions/create'
   root 'sessions#create'

   post 'login', to: 'sessions#create'
   delete 'logout', to: 'sessions#destroy'

    resources :categories, only: [:index, :show]

   resources :order_items, only: [:create, :update, :desrtroy]

   resources :orders, only: [:index, :show, :create, :update] do 
    member do
      get 'checkout'
    end
  end

  resources :users, only: [:show, :create, :update] do
    resources :orders, only: [:index, :show]
  end
  
  resources :products do
    collection do
      get 'search' 
      get 'index' 
      get 'show'
      post 'create' 
      delete 'update' 
      delete 'destroy'
    end
  end
  # resources :customers
 
end
