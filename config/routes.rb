Hipsterscore::Application.routes.draw do
  resources :pages

  resources :users

  root :to => "pages#index"
  
  match "/auth/facebook/callback" => "sessions#create"
end
