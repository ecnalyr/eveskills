Eveskills::Application.routes.draw do
  resources :api_keys


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end