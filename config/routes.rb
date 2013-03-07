Eveskills::Application.routes.draw do
  resources :api_keys
  match 'api_keys/pull_data/:id' => 'api_keys#pull_data', :via => :put


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :api_keys
end