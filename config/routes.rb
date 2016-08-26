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

end
