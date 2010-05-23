ActionController::Routing::Routes.draw do |map|
  map.namespace(:api) do |api|
    api.namespace(:v1) do |v1|
      v1.resources :users, 
                   :travel_fixes, 
                   :landmarks, 
                   :landmark_visits, 
                   :direction_distance_estimates, 
                   :regions, 
                   :log_entries
    end
  end
  
  map.devise_for :users
end
