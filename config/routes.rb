Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "homepage#index"

  get "/feeds", to: "homepage#index" # React will render the correct page for the route

  namespace "api" do
    resources :articles, only: [:index, :destroy]
    resources :feeds, only: :index
  end

  # devise_for :users # TODO: Add support for login UIs
end
