Hipsterscore::Application.routes.draw do
  resources :pages

  resources :users

  root :to => "pages#index"
  
  match "/auth/facebook/callback" => "sessions#create"
  match "/auth/failure" => "pages#failure"
  match "/signout" => "sessions#destroy"
  
end
