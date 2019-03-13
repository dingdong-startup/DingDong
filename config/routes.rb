Rails.application.routes.draw do

  get 'agencies/index'
  get 'agencies/show'
  get 'static_homes/index'
  devise_for :agencies
  resources :agencies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :agencies do 
    resources :properties, only: [:show, :edit, :update, :delete]
  end

  resources :properties, only: [:show]

  root 'statics#index'

end
