class Api::UsersController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /users.xml
  def index
    if current_user
      @users = User.find(:all, :conditions => {:id => current_user.id})
    end
    
    if current_user.roles.where(:title => 'admin').length > 0
      @users = User.all
    end
    
    # kludge!
    @users.each do |u|
      u.current_user = current_user
    end
    
    respond_to do |format|
      format.xml  { render :xml => @users }
      format.json { render :json => @users.to_json(:methods => [:is_current_user]) }
    end
  end

  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @user }
    end
  end

  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.xml  { render :xml => @user, :status => :created, :location => api_user_url(@user) }
      else
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    
    # Backbone shouldn't be sending all of this, but for now it is, so we want to ignore these extra attributes, which will never be updated from the browser-side
    ['last_mobile_client', 'encrypted_password', 'is_current_user', 'foursquare_user_id', 'created_at', 'average_north_direction_error', 'updated_at', 'last_sign_in_ip', 'dissstudythree_landmark_questionnaire_complete', 'average_absolute_distance_error', 'last_sign_in_at', 'average_absolute_direction_error', 'sign_in_count', 'password_salt', 'last_web_access', 'last_mobile_access', 'gave_consent', 'distance_traveled', 'reset_password_token', 'remember_token', 'last_region_id', 'current_sign_in_ip', 'remember_created_at', 'current_sign_in_at', 'participating_in_study'].each do |a|
      params[:user].delete(a)
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.xml  { render :xml => @user }
      else
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
