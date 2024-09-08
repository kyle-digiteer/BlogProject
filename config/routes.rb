Rails.application.routes.draw do
  devise_for :users
  resources :posts

  get 'feeds', to: 'posts#feeds', as: 'feeds'
  get 'feed/:id', to: 'posts#feed_show', as: 'feed'
  root 'posts#feeds'
end
