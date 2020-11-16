Rails.application.routes.draw do
  devise_for :users
  root to: 'shops#index'
  resources :shops do
    resources :products, except: [:destroy, :update]
    resources :delivery_options, only: [:index, :new, :create, :edit]
  end
  resources :products, only: [:destroy, :update]
  resources :delivery_options, only: [:destroy, :update]
  resources :addresses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
