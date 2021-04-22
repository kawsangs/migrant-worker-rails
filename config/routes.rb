# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, path: "/", controllers: { confirmations: "confirmations", omniauth_callbacks: "accounts/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "migrants#index"

  resources :accounts do
    post :update_locale, on: :collection
  end

  as :account do
    match "/confirmation" => "confirmations#update", :via => :put, :as => :update_account_confirmation
  end

  resources :migrants do
    get :download, on: :collection
    get :voice, on: :member
  end
  resource :about, only: [:show]

  resources :departures

  # Api
  namespace :api do
    namespace :v1 do
      resources :migrants, only: [:create]

      resources :pdfs, only: [] do
        get :download, on: :collection
      end
    end
  end
end
