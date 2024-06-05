Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  #for root
  root "pomodoro_settings#home"

  #for user_sessions
  get "login" , to: "user_sessions#new"
  post "login" , to: "user_sessions#create"
  delete "logout" , to: "user_sessions#destroy"

  #for users nested pomodoro_settings
  resources :users, only: %i[new create], shallow: true do
    resources :pomodoro_settings,only: %i[index show new create edit destroy]
  end
end
