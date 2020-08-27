Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

  resources :users
  put '/user_search', controller: 'users', action: :user_search

  resources :groups do
    put ':id', action: :show, as: :select
    post 'add_user/:user_id', action: :add_user, as: :add_user
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get '/.well-known/brave-rewards-verification.txt', to: redirect('/brave-rewards-verification.txt')

  get '/terms_and_conditions', to: "home#terms_and_conditions"
  get '/privacy_policy', to: "home#privacy_policy"
  put "accept_terms_and_purchase", to: "home#accept_terms_and_purchase"
  namespace :api do
    resources :groups do
      get :most_recent_waypoints
      get :sar_json
    end
  end

end
