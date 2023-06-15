Rails.application.routes.draw do

  devise_for :users do
    resources :reports, only: [:new, :create]
  end

  resources :contact_mailer, only: [:new, :create], path: 'contact', as: 'contact' do
    collection do
      get :confirmation
    end
  end

  get '/conditions' => 'static_pages#conditions'

  resources :reports do
    member do
      delete :delete_image_attachment
    end
  end

  resources :users, only: [:show, :edit, :update] do
    resources :avatars, only: [:create, :destroy]
    member do
      post :reset_password
    end
  end

  root to: "reports#index"

  namespace :admin do
    root to: 'admin#index'
    resources :users, :reports
  end
end

