Rails.application.routes.draw do

	root 'static_homes#index'
  get 'static_homes/index'
  devise_for :agencies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
