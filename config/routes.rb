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
  
  # study (for DissStudyThree)
  match '/study', :to => 'study#checklist', :as => :study_checklist
  match '/study/consent', :to => 'study#consent', :as => :study_consent
  match '/study/demographics', :to => 'study#demographics', :as => :study_demographics
  match '/study/sbsod', :to => 'study#sbsod', :as => :study_sbsod
  match '/study/landmarks', :to => 'study#landmarks', :as => :study_landmarks
  match '/study/final', :to => 'study#final', :as => :study_final
  
  # sign in/sign out
  devise_for :users
end
