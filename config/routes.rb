Rails.application.routes.draw do

  devise_for :users do
    resources :reports, only: [:new, :create]
  end

  resources :contact_mailer, only: [:new, :create] do
    collection do
      get :confirmation
    end
  end

  get '/conditions' => 'static_pages#conditions'
  get '/home' => 'static_pages#home'

  resources :reports do
    resources :comments, only: [:create, :update, :destroy]
    member do
      delete :delete_image_attachment
    end
  end

  resources :replies

  resources :users, only: [:show, :edit, :update]

  root to: "static_pages#home"

  namespace :admin do
    root to: 'admin#index'
    resources :users, :reports
  end
end

