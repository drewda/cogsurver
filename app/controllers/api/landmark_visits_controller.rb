class Api::LandmarkVisitsController < ApplicationController
  before_filter :authenticate_user!

  # GET /landmark_visits.xml
  def index
    if current_user
      @landmark_visits = LandmarkVisit.find(:all, :conditions => {:user_id => current_user.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @landmark_visits }
    end
  end

  # GET /landmark_visits/1.xml
  def show
    @landmark_visit = LandmarkVisit.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @landmark_visit }
    end
  end

  # POST /landmark_visits.xml
  def create
    @landmark_visit = LandmarkVisit.new(params[:landmark_visit])
    if current_user
      @landmark_visit.user = current_user
    end

    respond_to do |format|
      if @landmark_visit.save
        flash[:notice] = 'LandmarkVisit was successfully created.'
        format.xml  { render :xml => @landmark_visit, :status => :created, :location => api_landmark_visit_url(@landmark_visit) }
      else
        format.xml  { render :xml => @landmark_visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /landmark_visits/1.xml
  def update
    @landmark_visit = LandmarkVisit.find(params[:id])

    respond_to do |format|
      if @landmark_visit.update_attributes(params[:landmark_visit])
        flash[:notice] = 'LandmarkVisit was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @landmark_visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /landmark_visits/1.xml
  def destroy
    @landmark_visit = LandmarkVisit.find(params[:id])
    @landmark_visit.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
