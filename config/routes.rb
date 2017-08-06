Rails.application.routes.draw do
  resources :messages
  resources :topics
  resources :forums do
    resources :topics,  only: [:index, :create]
  end
  resources :organisations
  resources :users
end
