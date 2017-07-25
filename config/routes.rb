Rails.application.routes.draw do
  resources :messages
  resources :topics
  resources :forums
  resources :organisations
  resources :users
end
