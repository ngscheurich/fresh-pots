Rails.application.routes.draw do
  resources :coffee_types
  resources :brews
  resources :pots
  get "/home", to: "pages#home"
  root to: "pages#home"
end
