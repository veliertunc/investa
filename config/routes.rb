Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  # Redirect GET /users/sign_out to Devise's DELETE sign_out action
  devise_scope :user do
    get "/users/sign_out" => "users/sessions#destroy"
  end

  devise_for :admin_users, controllers: {
    sessions: "admin_users/sessions"
  }

  # Redirect GET /users/sign_out to Devise's DELETE sign_out action
  devise_scope :admin_user do
    get "/admin_users/sign_out" => "admin_users/sessions#destroy"
  end

  ActiveAdmin.routes(self)

  # Static pages
  root "static_pages#landing"
  get "/about", to: "static_pages#about", as: "about"
  get "/legal", to: "static_pages#legal", as: "legal"
  get "/contact", to: "static_pages#contact", as: "contact"
  get "/privacy", to: "static_pages#privacy", as: "privacy"
  # get "/pricing", to: "static_pages#pricing", as: "pricing"


  # Startup resources
  resources :startups do
    resources :listings
  end

  # Listing resources
  resources :listings do
    resources :investment_proposals, only: [ :create, :new ]
    member do
      post :favorite, to: "favorites#create"
      delete :unfavorite, to: "favorites#destroy"
    end
  end

  # Conversation resources
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  # Investment Proposal resources
  resources :investment_proposals, only: [ :index, :edit, :show, :update ] do
    member do
      post :accept
      post :reject
    end
  end

  resources :notifications, only: [ :index, :show ] do
    collection do
      post :mark_all_as_read
    end
  end
  # Dashboard
  resource :dashboard, only: [ :show ]

  # User profiles
  resources :investor_profiles

  # config/routes.rb
  resources :favorites, only: [ :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check

  # Catch-all route for undefined paths
  # get "*path", to: redirect("/404")

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
