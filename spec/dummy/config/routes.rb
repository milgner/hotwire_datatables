# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books do
    member do
      post :mark_read
      post :unmark_read
    end
  end
  root "books#index"
end
