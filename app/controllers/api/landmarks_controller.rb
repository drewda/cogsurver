class Api::LandmarksController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /landmarks.xml
  def index
    if current_user
      @landmarks = Landmark.find(:all, :conditions => {:user_id => current_user.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @landmarks }
      format.json { render :json => @landmarks.to_json(:methods => [:num_visits, :estimated_location]) }
    end
  end

  # GET /landmarks/1.xml
  def show
    @landmark = Landmark.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @landmark }
    end
  end

  # POST /landmarks.xml
  def create
    if current_user
      @landmark = Landmark.new(params[:landmark])
      @landmark.user = current_user
    end

    respond_to do |format|
      if @landmark.save
        format.xml  { render :xml => @landmark, :status => :created, :location => api_landmark_url(@landmark) }
        format.json { render :json => @landmark, :status => :created, :location => api_landmark_url(@landmark) }
      else
        format.xml  { render :xml => @landmark.errors, :status => :unprocessable_entity }
        format.json { render :json => @landmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /landmarks/1.xml
  def update
    @landmark = Landmark.find(params[:id])

    respond_to do |format|
      if @landmark.update_attributes(params[:landmark])
        format.xml  { render :xml => @landmark }
        format.json  { render :json => @landmark }
      else
        format.xml  { render :xml => @landmark.errors, :status => :unprocessable_entity }
        format.json  { render :json => @landmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /landmarks/1.xml
  def destroy
    @landmark = Landmark.find(params[:id])
    @landmark.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
