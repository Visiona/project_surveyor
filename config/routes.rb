Rails.application.routes.draw do
  root to: 'surveys#index'
  resources :surveys do
    resources :add_questions, :controller => "multiqs"
    resources :multi_answers, :only => [:new]
  end
end
