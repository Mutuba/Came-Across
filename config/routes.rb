# frozen_string_literal: true

Rails.application.routes.draw do
  root 'locations#index'
  resources :locations
  resources :locations do
    resources :comments do
      member do
        get :cancel_edit, as: :cancel_edit
      end
    end
  end
  post 'asset_uploads', to: 'asset_uploads#create'
end
