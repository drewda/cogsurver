ActionController::Routing::Routes.draw do |map|
  # api
  map.namespace(:api) do |api|
    api.resources :users, 
                  :travel_fixes, 
                  :landmarks, 
                  :landmark_visits, 
                  :direction_distance_estimates, 
                  :regions, 
                  :log_entries
  end
  
  # site
  map.root :controller => 'site',
           :action => 'land'
  
  # map arrangement
  map.do_map_arrangement '/map_arrangement',
                         :controller => 'map_arrangement', 
                         :action => 'do'

  # viewer
  map.viewer_main '/viewer',
                  :controller => 'viewer',
                  :action => 'main'
  
  # sign in/sign out
  map.devise_for :users
end
