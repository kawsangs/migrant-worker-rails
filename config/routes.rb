# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  devise_for :accounts, path: "/", controllers: { confirmations: "confirmations", omniauth_callbacks: "accounts/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users#index"

  get "/terms-and-conditions", to: "terms_and_conditions#index"
  get "/privacy-policy", to: "privacy_policy#index"

  resources :accounts do
    post :update_locale, on: :collection
    post :resend_confirmation, on: :member
  end

  as :account do
    match "/confirmation" => "confirmations#update", :via => :put, :as => :update_account_confirmation
  end

  resources :users do
    get :download, on: :collection

    resources :quizzes, only: [:index, :show], module: :users
  end

  resource :about, only: [:show]

  resources :categories
  resources :departures
  resources :safeties
  resources :category_images, only: [:create, :destroy]
  resources :notifications do
    put :release, on: :member
    put :cancel, on: :member
  end
  resources :videos
  resources :video_authors
  resources :video_tags
  resources :video_importers

  resources :institutions do
    member do
      delete :delete_logo
      delete :delete_audio
    end
  end

  # User story
  resources :story_forms do
    put :publish, on: :member
  end

  # Survey
  resources :survey_forms

  # Telegram bot
  get "helps/how-to-connect-telegram-bot", to: "helps#telegram_bot"

  resource :telegram_bot, only: [:show] do
    put :upsert, on: :collection
  end

  resources :chat_groups, only: [:index]

  # Api
  namespace :api do
    namespace :integration do
      # Telegram
      constraints Whitelist do
        telegram_webhook Api::Integration::TelegramWebhooksController
      end
    end

    namespace :v1 do
      resources :users, only: [:create]

      resources :countries, only: [:index] do
        resources :institutions, only: [:index]
        resources :country_institutions, only: :index
      end

      resources :pdfs, only: [] do
        get :download, on: :collection
      end

      resources :categories
      resources :departures, controller: :categories, type: "Categories::Departure", only: [:index, :show]
      resources :safeties, controller: :categories, type: "Categories::Safety", only: [:index, :show]

      resources :forms, only: [:index, :show]
      resources :quizzes, only: [:create]
      resources :answers, only: [:update]
      resource  :registered_tokens, only: [:update]
    end

    namespace :v2 do
      resources :users, only: [:create]

      resources :countries, only: [:index] do
        resources :institutions, only: [:index]
        resources :country_institutions, only: :index
      end

      resources :pdfs, only: [] do
        get :download, on: :collection
      end

      resources :categories
      resources :departures, controller: :categories, type: "Categories::Departure", only: [:index, :show]
      resources :safeties, controller: :categories, type: "Categories::Safety", only: [:index, :show]

      resources :forms, only: [:index, :show]
      resources :quizzes, only: [:create]
      resources :answers, only: [:update]
      resource  :registered_tokens, only: [:update]

      resources :videos, only: [:index]
      resources :survey_forms, only: [:show]
      resources :visits, only: [:create]
    end
  end

  if Rails.env.production?
    # Sidekiq
    authenticate :account, lambda { |u| u.system_admin? } do
      mount Sidekiq::Web => "/sidekiq"
    end
  else
    mount Sidekiq::Web => "/sidekiq"
  end
end
