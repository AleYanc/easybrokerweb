# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'properties#index'
  resources :properties, only: [:show]
  post 'post_contact', to: 'properties#post_contact'
end
