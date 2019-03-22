Rails.application.routes.draw do

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  devise_for :tenants


  devise_for :agencies, except: [:index]
  authenticated :agency do
    root 'agencies#show'
  end


  resources :agencies, except: [:index]  do
    resources :properties, except: [:index]
  end

  resources :agents, only: [:create, :update, :edit]



  resources :properties, only: [:index, :show] do 
    resources :visits, only: [:create, :update, :destroy]

  end

  resources :properties, only: [:index, :show] do
    resources :favorites, only: [:create, :update]
  end

  resources :tenants do
    resources :favorites, only: [:index]
  end

  resources :tenants, only: [:show, :edit, :update] do
    resources :properties, only: [:index]
  end

  resources :charges, only: [:index, :create]

  # put 'visits/update'


  root 'statics#index'

end
