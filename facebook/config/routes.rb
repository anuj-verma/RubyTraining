Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :users, only: [:index, :new, :create] do
  resources :addresses, only: [:show, :new, :create, :update]
end
# get 'users/index'
root 'users#index'
end
