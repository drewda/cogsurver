class LandmarksController < ApplicationController
  # GET /landmarks
  # GET /landmarks.xml
  def index
    @landmarks = Landmark.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @landmarks }
    end
  end

  # GET /landmarks/1
  # GET /landmarks/1.xml
  def show
    @landmark = Landmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @landmark }
    end
  end

  # GET /landmarks/new
  # GET /landmarks/new.xml
  def new
    @landmark = Landmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @landmark }
    end
  end

  # GET /landmarks/1/edit
  def edit
    @landmark = Landmark.find(params[:id])
  end

  # POST /landmarks
  # POST /landmarks.xml
  def create
    @landmark = Landmark.new(params[:landmark])

    respond_to do |format|
      if @landmark.save
        flash[:notice] = 'Landmark was successfully created.'
        format.html { redirect_to(@landmark) }
        format.xml  { render :xml => @landmark, :status => :created, :location => @landmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @landmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /landmarks/1
  # PUT /landmarks/1.xml
  def update
    @landmark = Landmark.find(params[:id])

    respond_to do |format|
      if @landmark.update_attributes(params[:landmark])
        flash[:notice] = 'Landmark was successfully updated.'
        format.html { redirect_to(@landmark) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @landmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /landmarks/1
  # DELETE /landmarks/1.xml
  def destroy
    @landmark = Landmark.find(params[:id])
    @landmark.destroy

    respond_to do |format|
      format.html { redirect_to(landmarks_url) }
      format.xml  { head :ok }
    end
  end
end
