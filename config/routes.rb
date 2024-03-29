# frozen_string_literal: true

Rails.application.routes.draw do
  resources :submissions do
    collection do
      get :edit_multiple
      put :update_multiple
    end
  end
  resources :users
  resources :contests do
    resources :questions
  end
  resources :sessions, only: %i[new create destroy]

  get '/', to: 'pages#index'
  get 'error', to: 'pages#error'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
