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

    namespace :api, format: "json" do
      get "brews/recent", to: "brews#recent"
      patch "brews/:id", to: "brews#exhaust"
    end
  end
end
