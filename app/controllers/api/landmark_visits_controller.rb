class Api::LandmarkVisitsController < ApplicationController
  # GET /landmark_visits
  # GET /landmark_visits.xml
  def index
    @landmark_visits = LandmarkVisit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @landmark_visits }
    end
  end

  # GET /landmark_visits/1
  # GET /landmark_visits/1.xml
  def show
    @landmark_visit = LandmarkVisit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @landmark_visit }
    end
  end

  # GET /landmark_visits/new
  # GET /landmark_visits/new.xml
  def new
    @landmark_visit = LandmarkVisit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @landmark_visit }
    end
  end

  # GET /landmark_visits/1/edit
  def edit
    @landmark_visit = LandmarkVisit.find(params[:id])
  end

  # POST /landmark_visits
  # POST /landmark_visits.xml
  def create
    @landmark_visit = LandmarkVisit.new(params[:landmark_visit])

    respond_to do |format|
      if @landmark_visit.save
        flash[:notice] = 'LandmarkVisit was successfully created.'
        format.html { redirect_to(@landmark_visit) }
        format.xml  { render :xml => @landmark_visit, :status => :created, :location => @landmark_visit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @landmark_visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /landmark_visits/1
  # PUT /landmark_visits/1.xml
  def update
    @landmark_visit = LandmarkVisit.find(params[:id])

    respond_to do |format|
      if @landmark_visit.update_attributes(params[:landmark_visit])
        flash[:notice] = 'LandmarkVisit was successfully updated.'
        format.html { redirect_to(@landmark_visit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @landmark_visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /landmark_visits/1
  # DELETE /landmark_visits/1.xml
  def destroy
    @landmark_visit = LandmarkVisit.find(params[:id])
    @landmark_visit.destroy

    respond_to do |format|
      format.html { redirect_to(landmark_visits_url) }
      format.xml  { head :ok }
    end
  end
end
