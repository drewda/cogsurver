ActionController::Routing::Routes.draw do |map|
  map.namespace(:api) do |api|
    api.resources :users, :landmarks, :landmark_visits, :direction_distance_estimates, :regions, :log_entries
  end
  
  devise_for :users
end
