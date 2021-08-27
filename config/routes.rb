# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root 'articles#index'
    resources :articles
    get 'articles/:id/:page_format', to: 'articles#show_format'
  end
end
