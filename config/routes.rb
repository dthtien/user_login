Rails.application.routes.draw do

  root "pages#home"

  get 'sign_up' => "users#new"
  resources :users, only: :create

  get 'log_in' => "sessions#new"
  post 'log_in' => "sessions#create"
  delete 'log_out' => "sessions#destroy"

  resources :articles
end
