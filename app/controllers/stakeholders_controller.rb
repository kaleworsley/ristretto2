class StakeholdersController < ApplicationController
  before_filter :authenticate_user!

  # GET /stakeholders
  # GET /stakeholders.xml
  def index
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stakeholders = @project.stakeholders

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @stakeholders }
    end
  end

  # GET /stakeholders/1
  # GET /stakeholders/1.xml
  def show
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stakeholder = @project.stakeholders.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @stakeholder }
    end
  end

  # GET /stakeholders/new
  # GET /stakeholders/new.xml
  def new
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stakeholder = @project.stakeholders.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @stakeholder }
    end
  end

  # GET /stakeholders/1/edit
  def edit
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stakeholder = @project.stakeholders.find(params[:id])
  end

  # POST /stakeholders
  # POST /stakeholders.xml
  def create
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stakeholder = @project.stakeholders.build(params[:stakeholder])

    respond_to do |format|
      if @stakeholder.save
        format.html { redirect_to customer_project_path(@customer, @project), :notice => 'Stakeholder was successfully created.' }
        format.xml { render :xml => @stakeholder, :status => :created, :location => @stakeholder }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @stakeholder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stakeholders/1
  # PUT /stakeholders/1.xml
  def update
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stakeholder = @project.stakeholders.find(params[:id])

    respond_to do |format|
      if @stakeholder.update_attributes(params[:stakeholder])
        format.html { redirect_to customer_project_stakeholders_path(@customer, @project), :notice => 'Stakeholder was successfully updated.' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @stakeholder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stakeholders/1
  # DELETE /stakeholders/1.xml
  def destroy
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stakeholder = @project.stakeholders.find(params[:id])
    @stakeholder.destroy

    respond_to do |format|
      format.html { redirect_to customer_project_stakeholders_path(@customer, @project) }
      format.xml { head :ok }
    end
  end
end

