class Api::GpsAccuracyMeasuresController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /gps_accuracy_measures.xml
  def index
    if current_user
      @gps_accuracy_measures = GpsAccuracyMeasure.find(:all, :conditions => {:user_id => current_user.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @gps_accuracy_measures }
      format.json { render :json => @gps_accuracy_measures.to_json(:methods => [:error_in_meters]) }
      format.kml
    end
  end

  # GET /gps_accuracy_measures/1.xml
  def show
    @gps_accuracy_measure = GpsAccuracyMeasure.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @gps_accuracy_measure }
      format.json { render :json => @gps_accuracy_measure }
    end
  end

  # POST /gps_accuracy_measures.xml
  def create
    @gps_accuracy_measure = GpsAccuracyMeasure.new(params[:gps_accuracy_measure])
    if current_user
      @gps_accuracy_measure.user = current_user
    end

    respond_to do |format|
      if @gps_accuracy_measure.save
        flash[:notice] = 'GpsAccuracyMeasure was successfully created.'
        format.xml   { render :xml => @gps_accuracy_measure, :status => :created, :location => api_gps_accuracy_measure_url(@gps_accuracy_measure) }
        format.json  { render :json => @gps_accuracy_measure, :status => :created, :location => api_gps_accuracy_measure_url(@gps_accuracy_measure) }
      else
        format.xml   { render :xml => @gps_accuracy_measure.errors, :status => :unprocessable_entity }
        format.json  { render :json => @gps_accuracy_measure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gps_accuracy_measures/1.xml
  def update
    @gps_accuracy_measure = GpsAccuracyMeasure.find(params[:id])

    respond_to do |format|
      if @gps_accuracy_measure.update_attributes(params[:gps_accuracy_measure])
        flash[:notice] = 'GpsAccuracyMeasure was successfully updated.'
        format.xml   { head :ok }
        format.json  { head :ok }
      else
        format.xml   { render :xml => @gps_accuracy_measure.errors, :status => :unprocessable_entity }
        format.json  { render :json => @gps_accuracy_measure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gps_accuracy_measures/1.xml
  def destroy
    @gps_accuracy_measure = GpsAccuracyMeasure.find(params[:id])
    @gps_accuracy_measure.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.json { render :json => nil, :status => 200 }
    end
  end
end
