class Api::RegionsController < ApplicationController
  # GET /regions.xml
  def index
    @regions = Region.all

    respond_to do |format|
      format.xml  { render :xml => @regions }
    end
  end

  # GET /regions/1
  # GET /regions/1.xml
  def show
    @region = Region.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @region }
    end
  end

  # POST /regions.xml
  def create
    @region = Region.new(params[:region])

    respond_to do |format|
      if @region.save
        flash[:notice] = 'Region was successfully created.'
        format.xml  { render :xml => @region, :status => :created, :location => api_region_url(@region) }
      else
        format.xml  { render :xml => @region.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /regions/1.xml
  def update
    @region = Region.find(params[:id])

    respond_to do |format|
      if @region.update_attributes(params[:region])
        flash[:notice] = 'Region was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @region.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1.xml
  def destroy
    @region = Region.find(params[:id])
    @region.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
