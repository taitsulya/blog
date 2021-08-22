# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'

  resources :articles
  get 'articles/:id/pdf', to: 'articles#show_pdf', defaults: { format: 'pdf' }
  get 'articles/:id/xml', to: 'articles#show_xml', defaults: { format: 'xml' }
end
