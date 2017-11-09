Rails.application.routes.draw do
  root to: "pages#home"

  get "/home", to: "pages#home"
  get "/dashboard", to: "pages#dashboard"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  devise_scope :user do
    get "/signup", to: "users/registrations#new"
    get "/login", to: "devise/sessions#new"
  end

  authenticate :user do
    resources :brews
    resources :pots
    resources :varieties

    get "/recent_brews", to: "recent_brews#index", format: "json"
  end
end
