Rails.application.routes.draw do

  get 'static_homes/index'
  devise_for :agencies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :agencies do 
    resources :properties, only: [:show, :edit, :update, :delete]
  end

  root 'statics#index'

end
