Rails.application.routes.draw do
  resources :pots
  get "/home", to: "pages#home"
  root to: "pages#home"
end
