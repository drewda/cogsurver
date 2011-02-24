class Api::TravelFixesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /travel_fixes.xml
  def index
    if current_user
      @travel_fixes = TravelFix.find(:all, :conditions => {:user_id => current_user.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @travel_fixes }
      format.json { render :json => @travel_fixes }
      format.kml
    end
  end

  # GET /travel_fixes/1.xml
  def show
    @travel_fix = TravelFix.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @travel_fix }
      format.json { render :json => @travel_fix }
    end
  end

  # POST /travel_fixes.xml
  def create
    @travel_fix = TravelFix.new(params[:travel_fix])
    if current_user
      @travel_fix.user = current_user
    end

    respond_to do |format|
      if @travel_fix.save
        flash[:notice] = 'TravelFix was successfully created.'
        format.xml  { render :xml => @travel_fix, :status => :created, :location => api_travel_fix_url(@travel_fix) }
      else
        format.xml  { render :xml => @travel_fix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travel_fixes/1.xml
  def update
    @travel_fix = TravelFix.find(params[:id])

    respond_to do |format|
      if @travel_fix.update_attributes(params[:travel_fix])
        flash[:notice] = 'TravelFix was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @travel_fix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_fixes/1.xml
  def destroy
    @travel_fix = TravelFix.find(params[:id])
    @travel_fix.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.json { render :json => nil, :status => 200 }
    end
  end
end
