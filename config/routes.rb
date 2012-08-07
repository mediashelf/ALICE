Alice::Application.routes.draw do
  resources :assets

  root :to => "catalog#index"

  Blacklight.add_routes(self)

  devise_for :users
end
