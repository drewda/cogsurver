class Api::DirectionDistanceEstimatesController < ApplicationController
  # GET /direction_distance_estimates.xml
  def index
    @direction_distance_estimates = DirectionDistanceEstimate.all

    respond_to do |format|
      format.xml  { render :xml => @direction_distance_estimates }
    end
  end

  # GET /direction_distance_estimates/1.xml
  def show
    @direction_distance_estimate = DirectionDistanceEstimate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @direction_distance_estimate }
    end
  end

  # POST /direction_distance_estimates.xml
  def create
    @direction_distance_estimate = DirectionDistanceEstimate.new(params[:direction_distance_estimate])

    respond_to do |format|
      if @direction_distance_estimate.save
        flash[:notice] = 'DirectionDistanceEstimate was successfully created.'
        format.xml  { render :xml => @direction_distance_estimate, :status => :created, :location => api_direction_distance_estimate_url(@direction_distance_estimate) }
      else
        format.xml  { render :xml => @direction_distance_estimate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /direction_distance_estimates/1.xml
  def update
    @direction_distance_estimate = DirectionDistanceEstimate.find(params[:id])

    respond_to do |format|
      if @direction_distance_estimate.update_attributes(params[:direction_distance_estimate])
        flash[:notice] = 'DirectionDistanceEstimate was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @direction_distance_estimate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /direction_distance_estimates/1.xml
  def destroy
    @direction_distance_estimate = DirectionDistanceEstimate.find(params[:id])
    @direction_distance_estimate.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
