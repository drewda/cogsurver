class Api::StudiesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /studies.xml
  def index
    if current_user
      @studies = current_user.studies
    end
    
    json = @studies.to_json
    
    if current_user.roles.where(:title => 'admin').length > 0
      @studies = Study.all
      json = @studies.to_json(:include => :users)
    end
    
    respond_to do |format|
      format.xml  { render :xml => @studies }
      format.json { render :json => json }
    end
  end

  # GET /studies/1.xml
  def show
    @study = Study.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @study }
    end
  end

  # POST /studies.xml
  def create
    @study = Study.new(params[:study])

    respond_to do |format|
      if @study.save
        flash[:notice] = 'Study was successfully created.'
        format.xml  { render :xml => @study, :status => :created, :location => api_study_url(@study) }
      else
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /studies/1.xml
  def update
    @study = Study.find(params[:id])

    respond_to do |format|
      if @study.update_attributes(params[:study])
        flash[:notice] = 'Study was successfully updated.'
        format.xml  { render :xml => @study }
      else
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /studies/1.xml
  def destroy
    @study = Study.find(params[:id])
    @study.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
