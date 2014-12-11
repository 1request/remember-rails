Rails.application.routes.draw do

  resources :users do
    get 'push', on: :member
  end
  resources :locations
  resources :groups
  resources :memberships
  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
