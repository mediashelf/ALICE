Alice::Application.routes.draw do
  ActiveAdmin.routes(self)

  resources :policy_areas, only: [:index, :show] do
    resources :sub_areas, only: [:index, :show]
  end

  resources :topics, only: [:index, :show]

  resources :assets


  root :to => "catalog#index"

  Blacklight.add_routes(self)

  devise_for :users

  match '/:slug' => 'pages#show'
end
