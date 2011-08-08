class TasksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :project, :through => :customer
  load_and_authorize_resource :task, :through => :project

  # GET /tasks
  # GET /tasks.xml
  def index
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @tasks = @project.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @task = @project.tasks.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @task = @project.tasks.build(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to customer_project_path(@customer, @project), :notice => 'Task was successfully created.' }
        format.xml { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to customer_project_tasks_path(@customer, @project), :notice => 'Task was successfully updated.' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to customer_project_tasks_path(@customer, @project) }
      format.xml { head :ok }
    end
  end
end

