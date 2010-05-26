class Api::LandmarksController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /landmarks.xml
  def index
    if current_user
      @landmarks = Landmark.find(:all, :conditions => {:user_id => current_user.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @landmarks }
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
    @landmark = Landmark.new(params[:landmark])

    respond_to do |format|
      if @landmark.save
        flash[:notice] = 'Landmark was successfully created.'
        format.html { redirect_to(@landmark) }
        format.xml  { render :xml => @landmark, :status => :created, :location => api_landmark_url(@landmark) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @landmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /landmarks/1.xml
  def update
    @landmark = Landmark.find(params[:id])

    respond_to do |format|
      if @landmark.update_attributes(params[:landmark])
        flash[:notice] = 'Landmark was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @landmark.errors, :status => :unprocessable_entity }
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
