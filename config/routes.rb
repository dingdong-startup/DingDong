Rails.application.routes.draw do

  get 'visits/index'
  get 'visits/new'
  get 'visits/create'
  get 'visits/show'
  devise_for :tenants
  get 'agencies/index'
  get 'agencies/show'
  get 'static_homes/index'
  devise_for :agencies

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :agencies do 
    resources :properties, except: [:index]
  end

  resources :properties, only: [:index, :show] do 
    resources :visits, only: [:new, :create, :delete]
  end

  resources :charges

  root 'statics#index'

end
