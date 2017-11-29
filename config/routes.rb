Rails.application.routes.draw do

  resources :registered_applications

  namespace :api, default: {format: :json} do

    resources :events, only: [:create]
  end

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

end
