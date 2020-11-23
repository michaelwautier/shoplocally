Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'shops#index'
  resources :shops do
    resources :products, except: [:destroy, :update]
    resources :delivery_options, only: [:index, :new, :create, :edit]
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  # orders and deliveries
  resources :orders, only: [:index, :show] do
    resources :deliveries, only: [:show]
  end

  # products by category
  get 'categories/:id', to: 'categories#show'

  # shop independent product actions
  post 'products/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  resources :products, only: [:destroy, :update]

  # cart actions
  get 'cart/', to: 'carts#show', as: 'current_cart'
  get 'cart/checkout/', to: 'carts#checkout', as: 'cart_checkout'
  post 'cart/checkout/', to: 'carts#checkout_confirmation', as: 'cart_checkout_confimation'

  # shop independent delivery_option actions
  resources :delivery_options, only: [:destroy, :update]

  resources :addresses
end
