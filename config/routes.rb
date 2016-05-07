Rails.application.routes.draw do
  resources :groups
  resources :comments
  resources :users
  
  root "comments#index"
end
