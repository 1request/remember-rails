Rails.application.routes.draw do

  root 'welcome#index'

  resources :users do
    get 'push', on: :member
    get 'picture', on: :member
    get 'thumbnail', on: :member
    get 'groups', on: :member
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

  get '*path' => 'welcome#index'
end
