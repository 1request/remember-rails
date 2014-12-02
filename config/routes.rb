Rails.application.routes.draw do
  resources :users

  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
