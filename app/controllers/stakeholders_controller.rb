class StakeholdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :project, :through => :customer
  load_and_authorize_resource :stakeholder, :through => :project
  inherit_resources
  nested_belongs_to :customer, :project

  def create
    create! { customer_project_path(@customer, @project) }
  end

  def update
    update! { customer_project_stakeholders_path(@customer, @project) }
  end
end

