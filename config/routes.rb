Rails.application.routes.draw do
  devise_for :users

  devise_for :admin_users, path: "admin"
  ActiveAdmin.routes(self)

  # Static pages
  root "static_pages#landing"
  get "/about", to: "static_pages#about"
  get "/terms", to: "static_pages#terms"
  get "/privacy", to: "static_pages#privacy"


  # Startup resources
  resources :startups do
    resources :listings
  end

  # Listing resources
  resources :listings do
    resources :investment_proposals, only: [ :create, :new ]
  end

  # Conversation resources
  resources :conversations, only: [ :index, :show, :new ] do
    resources :messages
  end

  # Investment Proposal resources
  resources :investment_proposals, only: [ :index, :edit, :show, :update ]

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
  resources :favorites, only: [ :index, :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check

  # Error pages
  # match "/404", to: "errors#not_found", via: :all
  # match "/500", to: "errors#internal_server_error", via: :all

  # Catch-all route for undefined paths
  # get "*path", to: "errors#not_found", via: :all

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
