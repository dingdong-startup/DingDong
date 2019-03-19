Rails.application.routes.draw do

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :tenants
  get 'agencies/index'
  get 'agencies/show'
  get 'static_homes/index'

  devise_for :agencies
  authenticated :agency do
    root :to => 'agencies#show'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :agencies do 
    resources :properties, except: [:index]
  end

  resources :agents, only: [:create, :update, :edit]


  resources :properties, only: [:index, :show] do 
    resources :visits, only: [:create]
  end

  resources :tenants, only: [:show, :edit, :update] do 
    resources :properties, only: [:index]
  end

  resources :charges, only: [:index, :create]

  put 'visits/update'

  root 'statics#index'

end
