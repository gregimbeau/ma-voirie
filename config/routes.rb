Rails.application.routes.draw do
  devise_for :users do
    resources :reports, only: [:new, :create]
  end
  resources :reports
  resources :users, only:[:show]

  root to: "reports#index"
end
