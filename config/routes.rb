Rails.application.routes.draw do
  resources :tasks
  resources :courses
  devise_for :users

  root 'application#introduction'
  post '/tasks/updatecomplete/:id', to: 'tasks#update_task_complete', as: :updatecomplete
  get '/introduction', to: 'application#introduction'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
