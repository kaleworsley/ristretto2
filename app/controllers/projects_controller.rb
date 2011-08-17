class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources
  belongs_to :customer, :optional => true
  load_and_authorize_resource :project
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :project, :through => :customer
  respond_to :html, :json, :xml
  has_scope :state
end

