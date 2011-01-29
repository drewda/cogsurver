class SiteController < ApplicationController
  before_filter :authenticate_user!
  
  def land
    if !current_user.participating_in_study
      redirect_to viewer_main_path
    elsif (current_user.participating_in_study == "images_own_phone" or current_user.participating_in_study == "images_borrow_phone")
      redirect_to study_checklist_path
    end
  end
end