Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
=begin
     resources :users, only: [:index, :new, :create] do
	resources :addresses, only: [:show, :new, :create, :update]
end
=end

  resources :users
  resources :post
  # get 'users/index'
root 'users#index'
end
