Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles do
    resources :comments
    member do
      post :notify_friend
    end
  end
  get 'salutation/hello'
  resources :users
  resource :session
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
