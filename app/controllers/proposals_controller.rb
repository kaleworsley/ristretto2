class ProposalsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :project, :through => :customer
  load_and_authorize_resource :task, :through => :project

  # GET /proposals/1
  # GET /proposals/1.json
  def show
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @proposal = @project.proposal

    respond_to do |format|
      format.html { redirect_to new_customer_project_proposal_path(@customer, @project) unless @proposal.present? }
      format.json { render :json => @proposal }
    end
  end

  # GET /proposals/new
  # GET /proposals/new.json
  def new
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @proposal = @project.build_proposal(:hourly_rate => CONFIG[:proposal_hourly_rate], :version => CONFIG[:proposal_version])

    @proposal.stages.each do |stage|
      @proposal.project.tasks.build(:stage => stage)
      @proposal.project.tasks.build(:stage => stage)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @proposal }
    end
  end

  # GET /proposals/1/edit
  def edit
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @proposal = @project.proposal

    @proposal.stages.each do |stage|
      @proposal.project.tasks.build(:stage => stage)
      @proposal.project.tasks.build(:stage => stage)
    end

  end

  # POST /proposals
  # POST /proposals.json
  def create
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @proposal = @project.build_proposal(params[:proposal])

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to customer_project_proposal_path(@customer, @project), :notice => 'Proposal was successfully created.' }
        format.json { render :json => @proposal, :status => :created, :location => @proposal }
      else
        format.html { render :action => "new" }
        format.json { render :json => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proposals/1
  # PUT /proposals/1.json
  def update
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @proposal = @project.proposal

    respond_to do |format|
      if @proposal.update_attributes(params[:proposal])
        format.html { redirect_to customer_project_proposal_path(@customer, @project), :notice => 'Proposal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @customer = current_user.customers.find(params[:customer_id])
    @project = @customer.projects.find(params[:project_id])
    @proposal = @project.proposal
    @proposal.destroy

    respond_to do |format|
      format.html { redirect_to customer_project_path(@customer, @project) }
      format.json { head :ok }
    end
  end
end

