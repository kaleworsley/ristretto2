class StagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :project, :through => :customer
  load_and_authorize_resource :stage, :through => :project

  # GET /stages/1/edit
  def edit
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stage = @project.stages.find(params[:id])
  end

  # PUT /stages/1
  # PUT /stages/1.xml
  def update
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @stage = @project.stages.find(params[:id])

    respond_to do |format|
      if @stage.update_attributes(params[:stage])
        format.html { redirect_to customer_project_url(@customer, @project), :notice => 'Stage was successfully updated.' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @stage.errors, :status => :unprocessable_entity }
      end
    end
  end

end

