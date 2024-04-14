Rails.application.routes.draw do
  get 'feed/index', as: :feed 

  
  resources :posts, only: %i[ show new create edit update ]
  resources :logins, only: %i[ new create destroy ]
  resources :registrations, only: %i[ new create ]

  root "feed#index"
end
