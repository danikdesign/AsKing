Rails.application.routes.draw do
  concern :commentable do
    resources :comments, only: %i[create destroy]
  end

  resource :session, only: %i[new create destroy]

  resource :password_reset, only: %i[new create edit update]

  resources :users, only: %i[new create edit update]

  resources :questions, concerns: :commentable do
    resources :answers, except: %i[new show]
  end

  resources :answers, except: %i[new show], concerns: :commentable

  namespace :admin do
    resources :users, only: %i[index create edit update destroy]
  end

  root 'pages#index'

end
