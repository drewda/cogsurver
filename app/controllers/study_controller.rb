class StudyController < ApplicationController
  def checklist
    redirect_to study_consent_path if !current_user.gave_consent
  end
  
  def consent
    if request.post?
      user = current_user
      user.gave_consent = Time.now
      if user.save()
        flash[:message] = "Thank you for agreeing to participate."
        redirect_to study_checklist_path
      end
    end
  end
  
  def demographics
    if request.get?
      @dissstudythree_demographics_questionnaire = DissstudythreeDemographicsQuestionnaire.new
      
    elsif request.post?
      @dissstudythree_demographics_questionnaire = DissstudythreeDemographicsQuestionnaire.new(params[:dissstudythree_demographics_questionnaire])
      @dissstudythree_demographics_questionnaire.user = current_user
      
      respond_to do |format|
        if @dissstudythree_demographics_questionnaire.save
          flash[:message] = "Thank you for completing the demographics questionnaire."
          format.html { redirect_to(study_checklist_path) }
        else
          flash[:error] = "There was an error saving your demographics questionnaire. Did you answer all the questions?"
          format.html {}
        end
      end
    end
  end
  
  def sbsod
    if request.get?
      @sbsod_record = SbsodRecord.new
      
    elsif request.post?
      @sbsod_record = SbsodRecord.new(params[:sbsod_record])
      @sbsod_record.user = current_user
      
      respond_to do |format|
        if @sbsod_record.save
          flash[:message] = "Thank you for completing the sense of direction questionnaire."
          format.html { redirect_to(study_checklist_path) }
        else
          flash[:error] = "There was an error saving your sense of direction questionnaire. Did you answer all the questions?"
          format.html {}
        end
      end
    end
  end
  
  def landmarks
    
  end
  
  def final
    if request.get?
      @dissstudythree_final_questionnaire = DissstudythreeFinalQuestionnaire.new
      
    elsif request.post?
      @dissstudythree_final_questionnaire = DissstudythreeFinalQuestionnaire.new(params[:dissstudythree_final_questionnaire])
      @dissstudythree_final_questionnaire.user = current_user
      
      respond_to do |format|
        if @dissstudythree_final_questionnaire.save
          flash[:message] = "Thank you for completing the final questionnaire."
          format.html { redirect_to(study_checklist_path) }
        else
          flash[:error] = "There was an error saving your final questionnaire. Did you answer all the questions?"
          format.html {}
        end
      end
    end
  end
end