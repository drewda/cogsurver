class Api::CompassAccuracyMeasuresController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /compass_accuracy_measures.xml
  def index
    if current_user
      @compass_accuracy_measures = CompassAccuracyMeasure.find(:all, :conditions => {:user_id => current_user.id})
    end

    respond_to do |format|
      format.xml  { render :xml => @compass_accuracy_measures }
      format.json { render :json => @compass_accuracy_measures }
      format.kml
    end
  end

  # GET /compass_accuracy_measures/1.xml
  def show
    @compass_accuracy_measure = CompassAccuracyMeasure.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @compass_accuracy_measure }
      format.json { render :json => @compass_accuracy_measure }
    end
  end

  # POST /compass_accuracy_measures.xml
  def create
    @compass_accuracy_measure = CompassAccuracyMeasure.new(params[:compass_accuracy_measure])
    if current_user
      @compass_accuracy_measure.user = current_user
    end

    respond_to do |format|
      if @compass_accuracy_measure.save
        flash[:notice] = 'CompassAccuracyMeasure was successfully created.'
        format.xml  { render :xml => @compass_accuracy_measure, :status => :created, :location => api_compass_accuracy_measure_url(@compass_accuracy_measure) }
      else
        format.xml  { render :xml => @compass_accuracy_measure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /compass_accuracy_measures/1.xml
  def update
    @compass_accuracy_measure = CompassAccuracyMeasure.find(params[:id])

    respond_to do |format|
      if @compass_accuracy_measure.update_attributes(params[:compass_accuracy_measure])
        flash[:notice] = 'CompassAccuracyMeasure was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @compass_accuracy_measure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /compass_accuracy_measures/1.xml
  def destroy
    @compass_accuracy_measure = CompassAccuracyMeasure.find(params[:id])
    @compass_accuracy_measure.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.json { render :json => nil, :status => 200 }
    end
  end
end
