# frozen_string_literal: true

Rails.application.routes.draw do
  resources :urls, param: :uuid, only: %i[create show] do
    get :stats
  end
end
