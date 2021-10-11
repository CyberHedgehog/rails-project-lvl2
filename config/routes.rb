Rails.application.routes.draw do
  resources :posts
  root 'home#index'
  resources :post_categories, only: :index
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
end
