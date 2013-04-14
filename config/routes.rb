Skiftpetition::Application.routes.draw do
  get "matches/index"

  root :to => "information#index"

  get "information/index"

  get "results/index"

  resources :registrations

end
