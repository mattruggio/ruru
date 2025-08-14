Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"

  resource :session, only: %i[new create destroy]

  resources :passwords, param: :token

  resources :validate_join_code_forms, only: %i[new create]

  resources :join_season_forms, only: %i[new create]

  resources :seasons, only: %i[index show new create] do
    resources :teams, only: :index, controller: "seasons/teams"
    resources :draft_logs, only: :index, controller: "seasons/draft_logs"
    resources :players, only: :index, controller: "seasons/players"

    member do
      post :begin_draft
    end
  end
end
