class Api::LogEntriesController < ApplicationController
  # GET /log_entries.xml
  def index
    @log_entries = LogEntry.all

    respond_to do |format|
      format.xml  { render :xml => @log_entries }
    end
  end

  # GET /log_entries/1.xml
  def show
    @log_entry = LogEntry.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @log_entry }
    end
  end

  # POST /log_entries.xml
  def create
    @log_entry = LogEntry.new(params[:log_entry])

    respond_to do |format|
      if @log_entry.save
        flash[:notice] = 'LogEntry was successfully created.'
        format.xml  { render :xml => @log_entry, :status => :created, :location => api_log_entry_url(@log_entry) }
      else
        format.xml  { render :xml => @log_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /log_entries/1.xml
  def update
    @log_entry = LogEntry.find(params[:id])

    respond_to do |format|
      if @log_entry.update_attributes(params[:log_entry])
        flash[:notice] = 'LogEntry was successfully updated.'
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @log_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /log_entries/1.xml
  def destroy
    @log_entry = LogEntry.find(params[:id])
    @log_entry.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
