Skiftpetition::Application.routes.draw do
  root :to => "information#index"

  get "information/index"

  resources :registrations

end
