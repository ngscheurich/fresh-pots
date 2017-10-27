Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  authenticate :user do
    resources :coffee_types
    resources :brews
    resources :pots
  end

  get "/home", to: "pages#home"
  root to: "pages#home"

  get "/recent_brews", to: "recent_brews#index", format: "json"
end
