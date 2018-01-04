Rails.application.routes.draw do
  root to: "pages#home"

  get "/home", to: "pages#home"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_scope :user do
    get "/signup", to: "users/registrations#new"
    get "/login", to: "devise/sessions#new"
  end

  namespace :api, format: "json" do
    get "users/:id", to: "users#show"
  end

  authenticate :user do
    resources :brews
    resources :pots
    resources :varieties
    resources :users, only: [:show, :edit, :update]

    get "/dashboard", to: "pages#dashboard"
    get "/me", to: "users#me"

    namespace :api, format: "json" do
      get "brews/recent", to: "brews#recent"
      patch "brews/:id", to: "brews#exhaust"
    end
  end
end
