Rails.application.routes.draw do
  # resources :post_comments
  root 'posts#index'
  resources :posts do
    resources :likes, module: :posts, only: %i[create destroy]
    resources :comments, module: :posts, only: %i[create]
  end

  resources :post_categories, only: :index
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
end
