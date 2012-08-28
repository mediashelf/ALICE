Alice::Application.routes.draw do

  resources :policy_areas do
    resources :sub_areas do
      resources :topics
    end
  end

  resources :topics
  resources :assets

  root :to => "catalog#index"

  Blacklight.add_routes(self)

  devise_for :users
end
