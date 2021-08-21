# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'

  resources :articles
  get 'articles/:id/pdf', to: 'articles#show_pdf', defaults: { format: 'pdf' }
end
