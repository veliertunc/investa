Rails.application.routes.draw do
  devise_for :users
  # Static pages
  root "static_pages#landing"
  get "/about", to: "static_pages#about"
  get "/terms", to: "static_pages#terms"
  get "/privacy", to: "static_pages#privacy"

  # Startup resources
  resources :startups do
    resources :listings, except: [ :index, :show ]
  end

  # Listing resources
  resources :listings, only: [ :index, :show ] do
    resources :investment_proposals, only: [ :create ]
  end

  # Conversation resources
  resources :conversations, only: [ :index, :show, :create ] do
    resources :messages, only: [ :create ]
  end

  # Notification routes
  resources :notifications, only: [ :index ] do
    collection do
      post :mark_all_as_read
    end
    member do
      get :read
    end
  end

  # Dashboard
  resource :dashboard, only: [ :show ]

  # User profiles
  resources :investor_profiles, only: [ :show, :new, :create, :edit, :update ]

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Error pages
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # Catch-all route for undefined paths
  get "*path", to: "errors#not_found", via: :all

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
