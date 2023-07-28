# frozen_string_literal: true

Rails.application.routes.draw do
  root 'locations#index'
  resources :locations
  resources :locations do
    resources :comments, only: [:destroy, :create]
  end
  post 'image_uploads', to: 'image_uploads#create'
end
