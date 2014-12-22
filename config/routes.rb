Rails.application.routes.draw do

  resources :users do
    get 'push', on: :member
    get 'picture', on: :member
  end
  resources :locations
  resources :groups
  resources :memberships do
    post 'unregister', on: :collection
  end
  resources :audios
  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
