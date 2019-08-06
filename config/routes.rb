Rails.application.routes.draw do
  resources :locations
  resources :mods
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get '/leaderboards', to: 'welcome#leaderboards', as: :leaderboards
  get '/closed', to: 'welcome#closed', as: :closed

  resources :beers, only: [:index]
  resources :requests
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  get '/requests/feedback/:id', to: 'requests#feedback', as: :requests_feedback
  patch '/requests/feedback/:id', to: 'requests#feedback_path', as: :requests_feedback_path

  get '/sign_up', to: 'users#new', as: :sign_up

  get '/log_in', to: 'sessions#new', as: :log_in
  get '/log_out', to: 'sessions#destroy', as: :log_out

end
