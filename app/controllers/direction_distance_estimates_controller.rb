class DirectionDistanceEstimatesController < ApplicationController
  # GET /direction_distance_estimates
  # GET /direction_distance_estimates.xml
  def index
    @direction_distance_estimates = DirectionDistanceEstimate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @direction_distance_estimates }
    end
  end

  # GET /direction_distance_estimates/1
  # GET /direction_distance_estimates/1.xml
  def show
    @direction_distance_estimate = DirectionDistanceEstimate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @direction_distance_estimate }
    end
  end

  # GET /direction_distance_estimates/new
  # GET /direction_distance_estimates/new.xml
  def new
    @direction_distance_estimate = DirectionDistanceEstimate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @direction_distance_estimate }
    end
  end

  # GET /direction_distance_estimates/1/edit
  def edit
    @direction_distance_estimate = DirectionDistanceEstimate.find(params[:id])
  end

  # POST /direction_distance_estimates
  # POST /direction_distance_estimates.xml
  def create
    @direction_distance_estimate = DirectionDistanceEstimate.new(params[:direction_distance_estimate])

    respond_to do |format|
      if @direction_distance_estimate.save
        flash[:notice] = 'DirectionDistanceEstimate was successfully created.'
        format.html { redirect_to(@direction_distance_estimate) }
        format.xml  { render :xml => @direction_distance_estimate, :status => :created, :location => @direction_distance_estimate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @direction_distance_estimate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /direction_distance_estimates/1
  # PUT /direction_distance_estimates/1.xml
  def update
    @direction_distance_estimate = DirectionDistanceEstimate.find(params[:id])

    respond_to do |format|
      if @direction_distance_estimate.update_attributes(params[:direction_distance_estimate])
        flash[:notice] = 'DirectionDistanceEstimate was successfully updated.'
        format.html { redirect_to(@direction_distance_estimate) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @direction_distance_estimate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /direction_distance_estimates/1
  # DELETE /direction_distance_estimates/1.xml
  def destroy
    @direction_distance_estimate = DirectionDistanceEstimate.find(params[:id])
    @direction_distance_estimate.destroy

    respond_to do |format|
      format.html { redirect_to(direction_distance_estimates_url) }
      format.xml  { head :ok }
    end
  end
end
