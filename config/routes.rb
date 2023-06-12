Rails.application.routes.draw do
  devise_for :users
  resources :reports
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "reports#index"
end
