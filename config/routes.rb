# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :accounts, path: "/", controllers: { confirmations: "confirmations", omniauth_callbacks: "accounts/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "migrants#index"

  resources :accounts do
    post :update_locale, on: :collection
    post :resend_confirmation, on: :member
  end

  as :account do
    match "/confirmation" => "confirmations#update", :via => :put, :as => :update_account_confirmation
  end

  resources :migrants do
    get :download, on: :collection
    get :voice, on: :member
  end
  resource :about, only: [:show]

  resources :categories
  resources :departures
  resources :safeties
  resources :category_images, only: [:create, :destroy]

  # Api
  namespace :api do
    namespace :v1 do
      resources :migrants, only: [:create]

      resources :pdfs, only: [] do
        get :download, on: :collection
      end

      resources :categories
      resources :departures, controller: :categories, type: "Categories::Departure", only: [:index, :show]
      resources :safeties, controller: :categories, type: "Categories::Safety", only: [:index, :show]
    end
  end

  if Rails.env.production?
    # Sidekiq
    authenticate :account, lambda { |u| u.system_admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  else
    mount Sidekiq::Web => '/sidekiq'
  end
end
