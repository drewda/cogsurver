class Api::UsersController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /users.xml
  def index
    if current_user
      @users = User.find(:all, :conditions => {:id => current_user.id})
    end
    

    respond_to do |format|
      format.xml  { render :xml => @users }
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

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.xml  { head :ok }
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
