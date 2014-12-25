Rails.application.routes.draw do

  get 'dl' => 'home#dl'

  resources :users do
    get 'push', on: :member
    get 'picture', on: :member
    get 'thumbnail', on: :member
  end
  resources :locations
  resources :groups
  resources :memberships do
    post 'unregister', on: :collection
    post 'accept', on: :collection
    post 'reject', on: :collection
  end
  resources :audios
  resources :feedbacks

  require "feedbacks_api"
  mount Remember::FeedbackApi => '/'
end
