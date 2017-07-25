Rails.application.routes.draw do
  resources :topics
  resources :forums
  resources :organisations
  resources :users
end
