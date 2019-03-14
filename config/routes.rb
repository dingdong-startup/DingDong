Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :tenants
  get 'agencies/index'
  get 'agencies/show'
  get 'static_homes/index'

  devise_for :agencies


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :agencies do 
    resources :properties, except: [:index]
  end


  resources :properties, only: [:index, :show]

  resources :tenants, only: [:show, :edit, :update]

  root 'statics#index'

end
