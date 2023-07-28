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
  post 'image_uploads', to: 'image_uploads#create'
end
