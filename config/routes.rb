Rails.application.routes.draw do
  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
