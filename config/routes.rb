Rails.application.routes.draw do
  root 'site#index'

  namespace :api, defaults: { format: :json } do 
    resources :todos, except: [:new, :edit]
  end

  get '*path', to: 'site#index'
end