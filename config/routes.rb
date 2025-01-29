Rails.application.routes.draw do
  get "static_pages/landing"
  get "/messages", to: redirect("/conversations")
  devise_for :users
  resources :startups, only: [ :show, :edit, :update ]
  resources :startups do
    resources :listings, except: [ :index, :show ]
  end
  resources :listings, only: [ :index, :show ]
  resources :investor_profiles, only: [ :show, :edit, :update ]
  resources :conversations, only: [ :index, :show ] do
    resources :messages, only: [ :create ]
  end
  resources :notifications, only: [ :index ] do
    post :mark_all_as_read, on: :collection
    member do
      get :read
    end
  end


  # Custom route for dashboard
  get "/dashboard", to: "dashboards#show", as: :dashboard

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#landing"
end
