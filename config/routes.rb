# frozen_string_literal: true

Rails.application.routes.draw do
  root 'books#index'

  get 'books/index'

  resources :books do
    member do
      get :delete
    end
  end
end

