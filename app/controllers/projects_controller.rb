class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :project, :through => :customer

  # GET /projects
  # GET /projects.xml
  def index
    @customer = current_user.customers.find(params[:customer_id])
    @projects = @customer.projects

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        CONFIG[:project_stages].each do |stage|
          @project.stages.build(:name => stage.humanize).save!
        end
        format.html { redirect_to(customer_project_url(@customer, @project), :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(customer_project_url(@customer, @project), :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(customer_projects_url(@customer)) }
      format.xml  { head :ok }
    end
  end
end

