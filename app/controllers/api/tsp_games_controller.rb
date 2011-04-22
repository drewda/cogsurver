require 'fastercsv'

class Api::TspGamesController < ApplicationController
  before_filter :authenticate_user!

  # GET /tsp_games.xml
  def index
    if current_user
      @tsp_games = TspGame.find(:all, :conditions => {:user_id => current_user.id})
    end
    
    csv_string = FasterCSV.generate do |csv|
      csv << ["user",
              "TspStop", 
              "landmark",
              "north_direction_estimate",
              "familiarity",
              "gps_distance_from_previous_stop",
              "google_route_distance_from_previous_stop",
              "google_route_distance_from_previous_stop_rank",
              "straightline_distance_from_previous_stop",
              "straightline_distance_from_previous_stop_rank",
              "estimated_straightline_distance_from_previous_stop",
              "estimated_straightline_distance_from_previous_stop_rank"]
              
      TspStop.all.each do |tsp_stop|
        if tsp_stop.landmark_visit.north_direction_estimate
          north_direction_error = tsp_stop.landmark_visit.north_direction_estimate.absolute_direction_error
        else
          north_direction_error = nil
        end
        csv << [tsp_stop.tsp_game.user.first_name,
                tsp_stop.order, 
                tsp_stop.landmark.name,
                north_direction_error,
                tsp_stop.landmark.familiarity_rating,
                tsp_stop.gps_distance_from_previous_stop,
                tsp_stop.google_route_distance_from_previous_stop,
                tsp_stop.google_route_distance_from_previous_stop_rank,
                tsp_stop.straightline_distance_from_previous_stop,
                tsp_stop.straightline_distance_from_previous_stop_rank,
                tsp_stop.estimated_straightline_distance_from_previous_stop,
                tsp_stop.estimated_straightline_distance_from_previous_stop_rank]
      end
    end

    respond_to do |format|
      format.xml  { render :xml => @tsp_games }
      format.json { render :json => @tsp_games.to_json(:include => :tsp_stops) }
      format.csv  { send_data csv_string, :type => "text/csv", 
                 :filename=>"tsp_games.csv",
                 :disposition => 'attachment' }
    end
  end

  # GET /tsp_games/1.xml
  def show
    @tsp_game = TspGame.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @tsp_game }
    end
  end

  # POST /tsp_games.xml
  def create
    @tsp_game = TspGame.new(params[:tsp_game])
    if current_user
      @tsp_game.user = current_user
    end

    respond_to do |format|
      if @tsp_game.save
        flash[:notice] = 'TspGame was successfully created.'
        format.xml  { render :xml => @tsp_game, :status => :created, :location => api_tsp_game_url(@tsp_game) }
        format.json { render :json => @tsp_game, :status => :created, :location => api_tsp_game_url(@tsp_game) }
      else
        format.xml  { render :xml => @tsp_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tsp_games/1.xml
  def update
    @tsp_game = TspGame.find(params[:id])

    respond_to do |format|
      if @tsp_game.update_attributes(params[:tsp_game])
        flash[:notice] = 'TspGame was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @tsp_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tsp_games/1.xml
  def destroy
    @tsp_game = TspGame.find(params[:id])
    @tsp_game.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
