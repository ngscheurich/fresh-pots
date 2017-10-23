Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :coffee_types
    resources :brews
    resources :pots
  end

  get "/home", to: "pages#home"
  root to: "pages#home"
end
