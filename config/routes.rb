# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'

  resources :articles
  get 'articles/:id/:page_format', to: 'articles#show_format'
end
