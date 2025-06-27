Rails.application.routes.draw do
  get "carts/show"
  get "users/new"
  get "users/create"
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :products do
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ]
  resources :users, only: [:new, :create]

  resources :cart_items, only: [:create, :destroy]
  resource :cart, only: [:show] do
    delete 'clear', on: :member
  end

  post '/checkout', to: 'checkout#create', as: :checkout

  get '/checkout/success', to: 'checkout#success', as: :checkout_success

  # Defines the root path route ("/")
  # root "posts#index"
  root "products#index"
end
