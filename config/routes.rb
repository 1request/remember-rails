Rails.application.routes.draw do

  resources :users
  resources :locations
  resources :groups
  resources :memberships
  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
