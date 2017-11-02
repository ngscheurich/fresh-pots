Rails.application.routes.draw do
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
