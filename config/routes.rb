Rails.application.routes.draw do

  resources :users
  resources :locations
  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
