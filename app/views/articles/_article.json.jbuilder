# frozen_string_literal: true

json.extract! article, :id, :title, :body
json.url article_url(article, format: :json)
