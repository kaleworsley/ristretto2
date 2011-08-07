class TimeslicesController < ApplicationController
  before_filter :authenticate_user!

  # GET /timeslices
  # GET /timeslices.xml
  def index
    @timeslices = Timeslice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @timeslices }
    end
  end

  # GET /timeslices/1
  # GET /timeslices/1.xml
  def show
    @timeslice = Timeslice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @timeslice }
    end
  end

  # GET /timeslices/new
  # GET /timeslices/new.xml
  def new
    @timeslice = Timeslice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @timeslice }
    end
  end

  # GET /timeslices/1/edit
  def edit
    @timeslice = Timeslice.find(params[:id])
  end

  # POST /timeslices
  # POST /timeslices.xml
  def create
    @timeslice = Timeslice.new(params[:timeslice])

    respond_to do |format|
      if @timeslice.save
        format.html { redirect_to @timeslice, :notice => 'Timeslice was successfully created.' }
        format.xml { render :xml => @timeslice, :status => :created, :location => @timeslice }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @timeslice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timeslices/1
  # PUT /timeslices/1.xml
  def update
    @timeslice = Timeslice.find(params[:id])

    respond_to do |format|
      if @timeslice.update_attributes(params[:timeslice])
        format.html { redirect_to @timeslice, :notice => 'Timeslice was successfully updated.' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @timeslice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timeslices/1
  # DELETE /timeslices/1.xml
  def destroy
    @timeslice = Timeslice.find(params[:id])
    @timeslice.destroy

    respond_to do |format|
      format.html { redirect_to timeslices_url }
      format.xml { head :ok }
    end
  end
end

