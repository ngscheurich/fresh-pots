Rails.application.routes.draw do
  root to: "pages#home"

  get "/home", to: "pages#home"
  get "/dashboard", to: "pages#dashboard"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  get "/home", to: "pages#home"
  root to: "pages#home"

  authenticate :user do
    resources :brews
    resources :pots
    resources :varieties

    get "/recent_brews", to: "recent_brews#index", format: "json"
  end
end
