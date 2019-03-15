Rails.application.routes.draw do

  devise_for :admins
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


<<<<<<< HEAD
  resources :properties, only: [:index, :show] do 
=======
  resources :properties, only: [:index, :show] do
>>>>>>> dev
    resources :visits, only: [:create]
  end

  resources :tenants, only: [:show, :edit, :update]

<<<<<<< HEAD
  resources :charges, only: [:index, :create]
=======
  resources :admin_charges, only: [:index, :create]
>>>>>>> dev

  root 'statics#index'

end
