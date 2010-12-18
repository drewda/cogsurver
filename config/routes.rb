Cogsurver::Application.routes.draw do
  # api
  namespace :api do
    resources :users, 
              :travel_fixes, 
              :landmarks, 
              :landmark_visits, 
              :direction_distance_estimates, 
              :regions, 
              :log_entries
  end
  
  # site
  root :to => 'site#land'
  
  # viewer
  match '/viewer', :to => 'viewer#main', :as => :viewer_main
  
  # sign in/sign out
  devise_for :users
end
