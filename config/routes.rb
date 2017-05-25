Rails.application.routes.draw do
  root to: 'surveys#index'
  resources :surveys, :only => [:new, :create, :show]
end
