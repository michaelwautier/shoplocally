Rails.application.routes.draw do
  mount RailsAdmin::Engine => 'admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  resources :shops do
    resources :shopreviews
    resources :products, except: [:destroy, :update]
    resources :delivery_options, only: [:index, :new, :create, :edit]
  end

  mount StripeEvent::Engine, at: 'stripe-webhooks'

  # orders and deliveries
  get 'orders/:id/fakepay', to: 'orders#fake_payment' if Rails.env.development?

  resources :orders, only: [:index, :show] do
    resources :deliveries, only: [:show]
  end

  # delivery updates by shop and delivery guy
  patch 'deliveries/:id/assign', to: 'deliveries#assign'
  put 'deliveries/:id/assign', to: 'deliveries#assign'
  patch 'deliveries/:id/status', to: 'deliveries#update_status'
  put 'deliveries/:id/status', to: 'deliveries#update_status'
  
  resources :deliveries, only: [:index, :edit, :update]

  # search queries
  get 'search/', to: 'pages#search', as: 'search'

  # products by category
  get 'categories/:id', to: 'categories#show'

  # shop independent product actions
  post 'cart_products/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'cart_products/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  resources :products, only: [:destroy, :update] do
    resources :productreviews
  end

  get 'owner/', to: 'shops#owner', as: 'owner'

  # cart actions
  get 'cart/', to: 'carts#show', as: 'current_cart'
  get 'cart/checkout/', to: 'carts#checkout', as: 'cart_checkout'
  post 'cart/checkout/', to: 'carts#checkout_confirmation', as: 'cart_checkout_confimation'

  # shop independent delivery_option actions
  resources :delivery_options, only: [:destroy, :update]

  resources :addresses

  
end
