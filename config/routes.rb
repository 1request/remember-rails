Rails.application.routes.draw do

  resources :users
  resources :locations
  resources :groups
  resources :memberships
  resources :audios
  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
