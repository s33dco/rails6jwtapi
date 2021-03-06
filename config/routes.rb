# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '/api' do
    resources :users
    post '/auth', to: 'authentication#login'
    get '/auth', to: 'authentication#refresh'
  end
  match '/*', to: 'application#not_found', via: :all
end
