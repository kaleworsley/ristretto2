class ProposalsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :project, :through => :customer
  load_and_authorize_resource :task, :through => :project
  inherit_resources
  nested_belongs_to :customer, :project, :singleton => true


  def show
    unless @proposal.present?
      @project.create_proposal
      redirect_to edit_customer_project_proposal_path(@customer, @project)
    else
      show!
    end
  end
end

