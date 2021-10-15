Rails.application.routes.draw do
  resources :post_comments
  # resources :post_comments
  root 'posts#index'
  resources :posts do
    scope module: :posts do
      resources :comments, only: %i[new]
    end
  end

  resources :post_categories, only: :index
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
end
