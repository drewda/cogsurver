ActionController::Routing::Routes.draw do |map|
  map.namespace(:api) do |api|
    api.resources :users, 
                  :travel_fixes, 
                  :landmarks, 
                  :landmark_visits, 
                  :direction_distance_estimates, 
                  :regions, 
                  :log_entries
  end
  
  map.devise_for :users
end
