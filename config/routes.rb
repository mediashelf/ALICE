Alice::Application.routes.draw do
  resources :sub_areas

  resources :policy_areas

  resources :topics

  resources :assets

  root :to => "catalog#index"

  Blacklight.add_routes(self)

  devise_for :users
end
